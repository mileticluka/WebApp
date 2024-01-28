using System.Net.Mail;

namespace DAL.Services
{
    public class SmtpEmailService : IEmailService
    {
        public void SendEmail(string to, string subject, string body)
        {
            using (var client = new SmtpClient("localhost", 25))
            {
                var message = new MailMessage("RWA@example.com", to, subject, body);
                try
                {
                    client.Send(message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }

            }
        }
    }
}