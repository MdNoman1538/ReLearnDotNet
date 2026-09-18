namespace NexusCommerce.Domain;

public sealed record LineItem
{
    public Guid ProductId { get; init; }
    public string Sku { get; init; }
    public Money UnitPrice { get; init; }
    public int Quantity { get; init; }

    public LineItem(Guid productId, string sku, Money unitPrice, int quantity)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(sku);

        if (quantity <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(quantity), "Quantity must be greater than zero.");
        }

        ProductId = productId;
        Sku = sku;
        UnitPrice = unitPrice;
        Quantity = quantity;
    }

    public Money Subtotal => new(UnitPrice.Amount * Quantity, UnitPrice.Currency);
}

