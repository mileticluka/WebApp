using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;
using System.Collections.Generic;
using DAL.Services;
using DAL.DTO;
using DAL.Repositories;
using AutoMapper;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationRepository _notificationRepository;
        private readonly IEmailService _emailService;
        private readonly IMapper _mapper;

        public NotificationController(IMapper mapper, INotificationRepository notificationRepository, IEmailService emailService)
        {
            _notificationRepository = notificationRepository;
            _emailService = emailService;
            _mapper = mapper;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Notification>> GetNotifications()
        {
            var notifications = _notificationRepository.GetNotifications();
            return Ok(new { Message = "Successfully retrieved notifications", Data = notifications });
        }

        [HttpGet("{id}")]
        public ActionResult<Notification> GetNotification(int id)
        {
            var notification = _notificationRepository.GetNotification(id);

            if (notification == null)
            {
                return NotFound(new { Message = $"Notification with ID {id} not found" });
            }

            return Ok(new { Message = "Successfully retrieved notification", Data = notification });
        }

        [HttpGet("unsent")]
        public ActionResult<IEnumerable<Notification>> GetUnsentNotifications()
        {
            var unsentNotifications = _notificationRepository.GetUnsentNotifications();
            return Ok(new { Message = "Successfully retrieved unsent notifications", Data = unsentNotifications });
        }

        [HttpPost]
        public ActionResult<int> InsertNotification(NotificationDTO notificationDTO)
        {
            var notification = _mapper.Map<Notification>(notificationDTO);
            notification.CreatedAt = DateTime.Now;

            var notificationId = _notificationRepository.InsertNotification(notification);
            return CreatedAtAction(nameof(GetNotification), new { id = notificationId }, new { Message = "Successfully inserted notification", Data = notificationId });
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteNotification(int id)
        {
            _notificationRepository.DeleteNotification(id);
            return NoContent();
        }

        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, Notification notification)
        {
            if (id != notification.Id)
            {
                return BadRequest(new { Message = "Invalid request" });
            }

            _notificationRepository.UpdateNotification(notification);

            return NoContent();
        }

        [HttpPost("{id}/send")]
        public IActionResult SendNotification(int id)
        {
            var notification = _notificationRepository.GetNotification(id);

            if (notification == null)
            {
                return NotFound(new { Message = $"Notification with ID {id} not found" });
            }

            _notificationRepository.SendNotification(id);

            return NoContent();
        }

        [HttpPost("sendall")]
        public IActionResult SendAllNotifications()
        {
            var unsentNotifications = _notificationRepository.GetUnsentNotifications();

            foreach (var notification in unsentNotifications)
            {
                _notificationRepository.SendNotification(notification.Id);
            }

            return Ok(new {Message = "Notifications sent succesfully"});
        }
    }
}