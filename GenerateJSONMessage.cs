using Microsoft.Azure.ServiceBus;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Diagnostics;

namespace GenerateJSONMessage
{

	class SendToQueue
	{

		static IQueueClient queueClient;

		static void Main(string[] args)
		{

			String connectionStringLocal;
			String storedProcedure01 = "";
			String storedProcedure02 = "";
			String serviceBusConnection;
			String queueName = "";
			String sessionID;
			String jsonString;
			

			switch (args[0].ToLower())
			{
				case "provincestate":
					Console.WriteLine("ProvinceState");
					storedProcedure01 = "Message.upGetProvinceStateDetailItem";
					storedProcedure02 = "Message.upFlagProvinceStateDetailItem";
					queueName = "datavaultqueue01";
					break;
				case "country":
					Console.WriteLine("Country");
					storedProcedure01 = "Message.upGetCountryDetailItem";
					storedProcedure02 = "Message.upFlagCountryDetailItem";
					queueName = "datavaultqueue02";
					break;
				case "county":
					Console.WriteLine("County");
					storedProcedure01 = "Message.upGetCounTYDetailItem";
					storedProcedure02 = "Message.upFlagCounTYDetailItem";
					queueName = "datavaultqueue03";  //remember to change prior to deployment sb 03
					break;
				default:
					Console.WriteLine("Default");
					Console.WriteLine("ProvinceState");
					storedProcedure01 = "Message.upGetProvinceStateDetailItem";
					storedProcedure02 = "Message.upFlagProvinceStateDetailItem";
					queueName = "datavaultqueue01";
					break;
			}

			Stopwatch stopwatch = new Stopwatch();
			stopwatch.Start();

			connectionStringLocal = ConfigurationManager.AppSettings.Get("DatabaseServer");
			serviceBusConnection = ConfigurationManager.AppSettings.Get("ServiceBusConnection");

			SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
			builder.DataSource = "azuresqldatabaseserver.database.windows.net";
			builder.UserID = "azureUser";
			builder.Password = "passwordGoesHere";
			builder.InitialCatalog = "Covid19DataVaultForAzure";

			Console.WriteLine("The value of Remote DatabaseServer is: " + builder.DataSource);


			// create and open a connection object
			SqlConnection connection01 = new SqlConnection(connectionStringLocal);
			connection01.Open();

			//create a second connection for flagging sent message 
			SqlConnection connection02 = new SqlConnection(connectionStringLocal);
			connection02.Open();


			// create a command object identifying the stored procedure
			SqlCommand command01 = new SqlCommand(storedProcedure01, connection01)
			{   // set the command object so it knows to execute a stored procedure
				CommandType = CommandType.StoredProcedure
			};

			// create a second command object identifying the stored procedure
			SqlCommand command02 = new SqlCommand(storedProcedure02, connection02)
			{   // set a second  command object so it knows to execute a stored procedure
				CommandType = CommandType.StoredProcedure
			};


			//Input parameter for second stored procedure - flags item by ID
			SqlParameter HashValue01 = command02.Parameters.Add("@hashValue", SqlDbType.VarBinary);
			HashValue01.Direction = ParameterDirection.Input;


			SqlDataReader reader = command01.ExecuteReader();

			Console.WriteLine("\nGenerating JSON Message...\n");
			int rowNumber = 1;

			sessionID = Guid.NewGuid().ToString();

			try
			{

				//get current row from SQL table - keep executing reads after items flagged as complete
				while (reader.Read())
				{
					jsonString = reader.GetValue(0).ToString();
					Console.WriteLine(jsonString);

					//log sent item by hash to Message.SentCounTYDetail table
					HashValue01.Value = reader.GetSqlBinary(1);

					
					//method to send Service Bus message
					SendIt( sessionID, serviceBusConnection, queueName, jsonString).GetAwaiter().GetResult();

					//update Sent table
					command02.ExecuteNonQuery();

					//delay to allow Azure SQL Databse to enough time to Message.Confirm hash from target 
					//int waitPeriod = 233;
					//Console.WriteLine($"Wait period in (ms): {waitPeriod.ToString()}");
					//System.Threading.Thread.Sleep(waitPeriod);


					rowNumber += 1;

				}
			}
			catch (Exception exception)
			{
				Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
				if (connection01 != null)
				{ connection01.Close(); }
				if (reader != null)
				{ reader.Close(); }
				if (connection02 != null)
				{ connection02.Close(); }

			}
			finally
			{
				connection01.Close();
				connection02.Close();
			}

			Console.WriteLine("\nDone with transmit...\n");
			stopwatch.Stop();
			TimeSpan stopwatchElapsed = stopwatch.Elapsed;
			Console.WriteLine("Total Seconds: " + Convert.ToInt32(stopwatchElapsed.TotalSeconds));

		}

		static async Task SendIt(string sessionID, string serviceBusConnection, string queueName, string jsonString)
		{
			try
			{
				queueClient = new QueueClient(serviceBusConnection, queueName);

				var messageBody = jsonString;
				
				var message = new Message(Encoding.UTF8.GetBytes(messageBody));

				message.SessionId = sessionID;

				// Send the message to the queue
				await queueClient.SendAsync(message);

			}
			catch (Exception exception)
			{
				Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
			}

		}


	}
}





