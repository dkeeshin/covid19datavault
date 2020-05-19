using Microsoft.Azure.ServiceBus;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Collections.Specialized;

namespace GenerateJSONMessage
{
			
	class SendToQueue
	{

		static IQueueClient queueClient;

		static void Main(string[] args)
   		{
			String currentID;
			String fileNumber;
			String connectionString;
			String storedProcedure01 = "";
			String storedProcedure02 = "";
			string serviceBusConnection;
			String queueName = "";
			String jsonString;

			switch (args[0])
			{
				case "ProvinceState":
					Console.WriteLine("ProvinceState");
					storedProcedure01 = "Message.upGetProvinceStateDetailItem";
					storedProcedure02 = "Message.upFlagProvinceStateDetailItem";
					queueName = "datavaultqueue01";
					break;
				case "Country":
					Console.WriteLine("Country");
					storedProcedure01 = "Message.upGetCountryDetailItem";
					storedProcedure02 = "Message.upFlagCountryDetailItem";
					queueName = "datavaultqueue02";
					break;
				case "County":
					Console.WriteLine("County");
					storedProcedure01 = "Message.upGetCounTYDetailItem";
					storedProcedure02 = "Message.upFlagCounTYDetailItem";
					queueName = "datavaultqueue03";
					break;
				default:
					Console.WriteLine("Default");
					Console.WriteLine("ProvinceState");
					storedProcedure01 = "Message.upGetProvinceStateDetailItem";
					storedProcedure02 = "Message.upFlagProvinceStateDetailItem";
					queueName = "datavaultqueue01";
					break;
			}

			connectionString = ConfigurationManager.AppSettings.Get("DatabaseServer");
			serviceBusConnection = ConfigurationManager.AppSettings.Get("ServiceBusConnection");
			// Read a particular key from the config file            
			Console.WriteLine("The value of DatabaseServer is: " + connectionString);
			Console.WriteLine("The value of ServiceBusConnector is: " + serviceBusConnection);


			// create and open a connection object
			SqlConnection conn01 = new SqlConnection(connectionString);
			conn01.Open();

			//create a second connection for flagging file create item as done
			SqlConnection conn02 = new SqlConnection(connectionString);
			conn02.Open();
			
			// create a command object identifying the stored procedure
			SqlCommand cmd = new SqlCommand(storedProcedure01, conn01)
			{   // set the command object so it knows to execute a stored procedure
				CommandType = CommandType.StoredProcedure
			};

			// create a second command object identifying the stored procedure
			SqlCommand cmd02 = new SqlCommand(storedProcedure02, conn02)
			{   // set a second  command object so it knows to execute a stored procedure
				CommandType = CommandType.StoredProcedure
			};

			//Input parameter for second stored procedure - flags item by ID
			SqlParameter IDinput = cmd02.Parameters.Add("@ID", SqlDbType.Int);
			IDinput.Direction = ParameterDirection.Input;
			SqlDataReader reader = cmd.ExecuteReader();
			Console.WriteLine("\nGenerating JSON Message...\n");
				

			try
			{

				//get current row from SQL table - keep executing reads after items flagged as complete
				while (reader.Read())
				{
					fileNumber = reader.GetValue(2).ToString();  //assign filenumber from SQL Server row 
					
					jsonString = reader.GetValue(0).ToString();
					//method to send Service Bus message
					SendIt(serviceBusConnection, queueName, jsonString).GetAwaiter().GetResult();

					currentID = reader.GetValue(1).ToString(); //get value as a string
					IDinput.Value = Convert.ToInt32(currentID);  //convert it to int
					cmd02.ExecuteNonQuery(); //execute stored proc2 to flag file status as created
					reader.Close();  //close current reader
					reader = cmd.ExecuteReader();  //get next item
				}
			}
			catch (Exception exception)
			{
				Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
				if (conn01!= null)
				{conn01.Close(); }
				if (reader != null)
				{reader.Close();}
				if (conn02 != null)
				{conn02.Close();}
			}
			finally
			{
				conn01.Close();
				conn02.Close();
			}
				Console.WriteLine("\nDone\n");
		}

		static async Task SendIt(string serviceBusConnection, string queueName, string jsonString)
		{
			try
			{
			   queueClient = new QueueClient(serviceBusConnection, queueName);

				var messageBody = jsonString;
				var message = new Message(Encoding.UTF8.GetBytes(messageBody));
				
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
	
		

	

