//Azure Service Bus Trigger
//when a message is sent to Azure Service Bus Queue it triggers a SQL Server stored procedure  DK 20200610
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Azure.ServiceBus;
using Microsoft.Azure.Amqp.Framing;

namespace FunctionApp
{

 
    public static class Function3
    {

        private static int messageCounter ;  //makes sure first message generates only one database connection for current batch

        [FunctionName("Function3")]
        public static void Run(
                [ServiceBusTrigger("datavaultqueue03", Connection = "ServiceBus01")]
                string payLoad, ILogger log)
        {
            log.LogInformation($"C# ServiceBus queue trigger function processed message: {payLoad}");

            try           {
                                
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                //@"LoccalServerNameGoesHere\InstanceNameGoesHere"  
                builder.DataSource = "yourdatabaseservernamegoeshere.database.windows.net";
                builder.UserID = "userIDgoeshere";
                builder.Password = "passwordGoesHEre";
                builder.InitialCatalog = "Covid19DataVaultForAzure";

                using SqlConnection conn01 = new SqlConnection(builder.ConnectionString);
                conn01.Open();
                messageCounter += 1;
                Console.WriteLine("Connected...message count is " + messageCounter);

                //set sql command for a stored proceudre
                SqlCommand cmd = new SqlCommand("Message.upItemCounTYDetail", conn01)
                {   // set the command object so it knows to execute a stored procedure
                    CommandType = CommandType.StoredProcedure
                };
                SqlParameter message = cmd.Parameters.Add("@message", SqlDbType.NVarChar);
                message.Direction = ParameterDirection.Input;
                //assign payload from queue to stored procedure message parameter
                message.Value = payLoad;
                //execute stored procedure
                cmd.ExecuteNonQuery();
                conn01.Close();
                
            }
            catch (SqlException e)
            {
                log.LogError($"Error writing to database: {e.Message + ":::" + e.StackTrace}");
            }
            finally
            {
            }



        }
    }
}
