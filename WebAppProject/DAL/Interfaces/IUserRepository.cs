﻿using DAL.Models;

namespace DAL.Interfaces
{
    public interface IUserRepository
    {
        IEnumerable<User> GetUsers();
        User GetUserById(int userId);
        void AddUser(User user);
        void UpdateUser(User user);
        void DeleteUser(int userId);
        User GetUserByUsername(string username);
        IEnumerable<User> GetUserFiltered(String Query);
    }
}
