using System;
using System.Collections.Generic;
using System.Linq;
using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;
using Microsoft.EntityFrameworkCore;
using DAL.Services;

namespace DAL.Repositories
{
    public class NotificationRepository : INotificationRepository
    {
        private readonly RwamoviesContext _context;
        private readonly IEmailService _emailService;

        public NotificationRepository(RwamoviesContext context, IEmailService emailService)
        {
            _context = context;
            _emailService = emailService;
        }

        public IList<Notification> GetNotifications()
        {
            return _context.Notifications.ToList();
        }

        public Notification GetNotification(int id)
        {
            return _context.Notifications.FirstOrDefault(n => n.Id == id);
        }

        public IList<Notification> GetUnsentNotifications()
        {
            return _context.Notifications
                .Where(n => n.SentAt == null)
                .ToList();
        }

        public int InsertNotification(Notification notification)
        {
            _context.Notifications.Add(notification);
            _context.SaveChanges();
            return notification.Id;
        }

        public void DeleteNotification(int id)
        {
            var notification = _context.Notifications.Find(id);
            if (notification != null)
            {
                _context.Notifications.Remove(notification);
                _context.SaveChanges();
            }
        }

        public void UpdateNotification(Notification notification)
        {
            _context.Notifications.Update(notification);
            _context.SaveChanges();
        }

        public void SendNotification(int id)
        {
            var notification = _context.Notifications.Find(id);
            if (notification != null)
            {
                notification.SentAt = DateTime.UtcNow;
                SendEmailNotification(notification);
                _context.SaveChanges();
            }
        }

        public void SendNotifications()
        {
            var unsentNotifications = _context.Notifications
                .Where(n => n.SentAt == null)
                .ToList();

            foreach (var notification in unsentNotifications)
            {
                notification.SentAt = DateTime.UtcNow;
                SendEmailNotification(notification);
            }

            _context.SaveChanges();
        }
        public void SendEmailNotification(Notification notification)
        {
            if (!string.IsNullOrEmpty(notification.ReceiverEmail))
            {
                var emailSubject = notification.Subject;
                var emailBody = notification.Body;

                _emailService.SendEmail(notification.ReceiverEmail, emailSubject, emailBody);
            }
        }
    }
}
