namespace NexusCommerce.Domain;

public sealed class Order
{
    private readonly List<LineItem> _items = [];

    public Guid Id { get; }
    public Address ShippingAddress { get; private set; }
    public IReadOnlyCollection<LineItem> Items => _items.AsReadOnly();
    public string Currency { get; }

    public Order(Guid id, Address shippingAddress, string currency)
    {
        Id = id;
        ShippingAddress = shippingAddress;
        Currency = currency.ToUpperInvariant();
    }

    public void AddItem(LineItem item)
    {
        ArgumentNullException.ThrowIfNull(item);

        if (item.UnitPrice.Currency != Currency)
        {
            throw new InvalidOperationException($"LineItem currency ({item.UnitPrice.Currency}) does not match order currency ({Currency}).");
        }

        _items.Add(item);
    }

    public Money CalculateTotal()
    {
        if (_items.Count == 0)
        {
            return new Money(0m, Currency);
        }

        decimal totalAmount = _items.Sum(item => item.Subtotal.Amount);
        return new Money(totalAmount, Currency);
    }
}

