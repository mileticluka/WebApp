using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Models;
using DAL.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminModule.Controllers
{
    public class UserController : Controller
    {

        private IUserRepository _userRepository;

        private IMapper _mapper;

        public UserController(IUserRepository userRepository, IMapper mapper)
        {
            this._userRepository = userRepository;
            this._mapper = mapper;
        }

        [HttpGet]
        public IActionResult Index(string searchQuery)
        {
            IEnumerable<User> users;

            if (string.IsNullOrEmpty(searchQuery))
            {
                users = _userRepository.GetUsers();
            }
            else
            {
                users = _userRepository.GetUserFiltered(searchQuery);
            }

            var userViewModels = _mapper.Map<IEnumerable<UserViewModel>>(users);

            var model = new UserListViewModel
            {
                Users = userViewModels,
                TotalCount = userViewModels.Count(),
                SearchQuery = searchQuery
            };

            return View(model);
        }


        // GET: UserController/Details/5
        public ActionResult Details(int id)
        {
            var model = _mapper.Map<UserViewModel>(_userRepository.GetUserById(id));
            return View(model);
        }

        // GET: UserController/Edit/5
        public ActionResult Edit(int id)
        {
            _userRepository.updateUserStatus(id);
            return RedirectToAction("Index");
        }


        // POST: UserController/Delete/5
        public ActionResult Delete(int id)
        {
            _userRepository.DeleteUser(id);
            return RedirectToAction("Index");
        }
    }
}
