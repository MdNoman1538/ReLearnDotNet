using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;

namespace UserRegistrationApp.Pages
{
    public class RegisterUserModel : PageModel
    {
        private readonly ILogger<RegisterUserModel> _logger;

        public RegisterUserModel(ILogger<RegisterUserModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {

        }
    }
}