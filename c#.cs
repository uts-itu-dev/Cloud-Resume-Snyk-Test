using System;
using System.Data.SqlClient;

class SQLInjection {

        static void Main(string[] Args)
        {
                ReadOrderData("https://secureuts.com/", "Password", Args[1]);
        }

        static void ReadOrderData(string connectionString, string Password, string Username)
        {
                SecureString SS = new SecureString();
                foreach (char C in Password)
                        SS.AppendChar(C);

                SqlCredential SC = new SqlCredential("Hardcoded Username", SS);

                string queryString =
                        $"SELECT CustomerID FROM dbo.Orders WHERE username='{Username}';";
                using (SqlConnection connection = new SqlConnection(
                        connectionString, SC))
                {
                        SqlCommand command = new SqlCommand(
                                queryString, connection);
                        connection.Open();
                        using(SqlDataReader reader = command.ExecuteReader())
                        {
                                while (reader.Read())
                                {
                                        Console.WriteLine(String.Format("{0}, {1}",
                                                reader[0], reader[1]));
                                }
                        }
                }
        }
}