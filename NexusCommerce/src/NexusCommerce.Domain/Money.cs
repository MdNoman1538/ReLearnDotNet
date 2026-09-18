using System.Text.RegularExpressions;

namespace NexusCommerce.Domain;

public readonly partial record struct Money
{
    public decimal Amount { get; }
    public string Currency { get; }

    [GeneratedRegex("^[A-Z]{3}$")]
    private static partial Regex IsoCurrencyRegex();

    public Money(decimal amount, string currency)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(currency);

        var upperCurrency = currency.Trim().ToUpperInvariant();
        if (!IsoCurrencyRegex().IsMatch(upperCurrency))
        {
            throw new ArgumentException($"Currency '{currency}' is not a valid 3-letter ISO-4217 code.");
        }

        if (amount < 0)
        {
            throw new ArgumentException("Amount cannot be negative.", nameof(amount));
        }

        Amount = amount;
        Currency = upperCurrency;
    }

    public static Money operator +(Money left, Money right)
    {
        if (left.Currency != right.Currency)
        {
            throw new InvalidOperationException($"Cannot add money of different currencies: {left.Currency} and {right.Currency}");
        }

        return new Money(left.Amount + right.Amount, left.Currency);
    }
}

