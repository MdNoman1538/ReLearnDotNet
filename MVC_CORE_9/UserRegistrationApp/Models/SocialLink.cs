namespace UserRegistrationApp.Models;

public class SocialLink
{
    public int Id { get; set; }
    public int UserId { get; set; }

    public string Platform { get; set; } = string.Empty;
    public string UrlOrHandle { get; set; } = string.Empty;

    public User? User { get; set; }
}
