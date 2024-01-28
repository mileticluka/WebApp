using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface INotificationRepository
    {
        public IList<Notification> GetNotifications();
        public Notification GetNotification(int id);
        public IList<Notification> GetUnsentNotifications();

        public int InsertNotification(Notification n);

        public void DeleteNotification(int id);

        public void UpdateNotification(Notification notification);


        public void SendNotification(int id);
        public void SendNotifications();

        void SendEmailNotification(Notification notification);

    }
}
