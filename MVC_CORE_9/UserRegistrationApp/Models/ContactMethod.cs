namespace UserRegistrationApp.Models;

public class ContactMethod
{
    public int Id { get; set; }
    public int UserId { get; set; }

    public string Type { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
    public bool IsPrimary { get; set; }

    public User? User { get; set; }
}
