# GA4 Analytics Event Template

Google Tag Manager template for sending events to Google Analytics 4 (GA4).

## Description

This template allows you to send custom events to GA4 using two modes:
- **Data Layer**: reads events from the `eventObj` object in the dataLayer
- **Custom Event Parameters**: uses a custom variable to define the event

## Features

- Support for GA4 events with custom parameters
- GA4 Measurement ID validation (format: G-XXXXXXXXXX)
- Two configuration modes: Data Layer or Custom Variable
- Error handling with logging

## Configuration

### Required Parameters

1. **Measurement ID**: Your GA4 measurement ID (format: G-XXXXXXXXXX)
2. **Analytics Event Parameters**: Choose between:
   - **Data Layer**: Uses the `eventObj` object from the dataLayer
   - **Custom Event Parameters**: Uses a custom variable

### Data Layer Format

If you choose "Data Layer", make sure the dataLayer contains an `eventObj` object with this structure:

```javascript
{
  eventObj: {
    event_name: "event_name",
    params: {
      parameter1: "value1",
      parameter2: "value2"
    }
  }
}
```

### Custom Variable Format

If you choose "Custom Event Parameters", the custom variable must return an object with this structure:

```javascript
{
  event_name: "event_name",
  params: {
    parameter1: "value1",
    parameter2: "value2"
  }
}
```

## Usage Examples

### Example 1: Event from Data Layer

```javascript
dataLayer.push({
  eventObj: {
    event_name: "purchase",
    params: {
      transaction_id: "12345",
      value: 99.99,
      currency: "EUR"
    }
  }
});
```

### Example 2: Event from Custom Variable

Create a custom JavaScript variable that returns:

```javascript
function() {
  return {
    event_name: "button_click",
    params: {
      button_name: "Subscribe",
      page_location: window.location.href
    }
  };
}
```

## Notes

- The template automatically cleans the `eventObj` object from the dataLayer after sending
- In case of formatting errors, a message is logged to the console
- Make sure the Measurement ID is valid and that GA4 is properly configured in your GTM container

## Support

To report issues or request support, open an issue in the GitHub repository.

## License

Apache License 2.0
