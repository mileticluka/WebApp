using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace DAL.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly RwamoviesContext _context;

        public UserRepository(RwamoviesContext context)
        {
            _context = context;
        }

        public IEnumerable<User> GetUsers()
        {
            return _context.Users.Include(u => u.CountryOfResidence).ToList();
        }

        public User GetUserById(int userId)
        {
            return _context.Users.FirstOrDefault(u => u.Id == userId);
        }

        public void AddUser(User user)
        {
            _context.Users.Add(user);
            _context.SaveChanges();
        }

        public void UpdateUser(int userId, User user)
        {

            User existingUser = _context.Users.Find(userId);

            if(existingUser != null)
            {
                existingUser.IsConfirmed = user.IsConfirmed;

                _context.Entry(existingUser).State = EntityState.Modified;
                _context.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException($"USer with ID {userId} not found.");
            }

            _context.Users.Update(user);
            _context.SaveChanges();
        }


        public void DeleteUser(int userId)
        {
            var user = _context.Users.Find(userId);
            if (user != null)
            {
                _context.Users.Remove(user);
                _context.SaveChanges();
            }
        }

        public User GetUserByUsername(string username)
        {
            return _context.Users.FirstOrDefault(u => u.Username == username);
        }

        public IEnumerable<User> GetUserFiltered(string query)
        {
            return _context.Users.Include(u => u.CountryOfResidence)
            .Where(user =>
                user.FirstName.Contains(query) ||
                user.LastName.Contains(query) ||
                user.Username.Contains(query) ||
                user.CountryOfResidence.Name.Contains(query))
            .ToList();
        }

        public void updateUserStatus(int id)
        {
            User user = _context.Users.FirstOrDefault(user => user.Id == id);

            if (user == null)
            { return; }

            if (user.IsConfirmed)
            {
                user.IsConfirmed = false;
            }
            else
            {
                user.IsConfirmed = true;
            }

            _context.SaveChanges();
        }
    }
}