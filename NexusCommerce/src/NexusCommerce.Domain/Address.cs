namespace NexusCommerce.Domain;

public readonly record struct Address(
    string Street,
    string City,
    string Country,
    string PostalCode);


