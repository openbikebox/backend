# Beispiel-Requests

Alle Beispiele können [in der OpenAPI Dokumentation](https://backend.openbikebox.de/documentation) nachvollzogen werden.

## Vereinfachte Anfrage mit vordefinierten Zeiträumen

Daten via `/api/location/id`:

```json
{
  "data": {
    "address": "Beispielstraße", 
    "booking_url": "http://srv:8080/location/fahrrad-station-beispielstadt", 
    "country": "de", 
    "created": "2021-05-02T08:18:16Z", 
    "id": 1, 
    "lat": 51.517477, 
    "locality": "Beispielstadt", 
    "lon": 7.460547, 
    "modified": "2021-05-02T08:18:16Z", 
    "name": "Fahrrad-Station Beispielstadt", 
    "operator": {
      "address": "Fahrradstra\u00dfe 1", 
      "country": "de", 
      "created": "2021-05-02T08:18:16Z", 
      "id": 1, 
      "id_url": "https://backend.openbikebox.de/api/operator/1", 
      "locality": "Fahrradstadt", 
      "logo": {
        "created": "2021-05-02T08:18:16Z", 
        "id": 1, 
        "id_url": "https://backend.openbikebox.de/api/file/1", 
        "mimetype": "image/svg+xml", 
        "modified": "2021-05-02T08:18:16Z", 
        "url": "https://backend.openbikebox.de/static/files/1.svg"
      }, 
      "modified": "2021-05-02T08:18:16Z", 
      "name": "Open Bike GmbH", 
      "postalcode": "12345"
    }, 
    "operator_id": 1, 
    "photo": {
      "created": "2021-05-02T08:18:16Z", 
      "id": 2, 
      "id_url": "https://backend.openbikebox.de/api/file/2", 
      "mimetype": "image/jpeg", 
      "modified": "2021-05-02T08:18:16Z", 
      "url": "https://backend.openbikebox.de/static/files/2.jpg"
    }, 
    "photo_id": 2, 
    "postalcode": "44137", 
    "resource": [
      {
        "created": "2021-05-02T08:18:16Z", 
        "id": 1, 
        "id_url": "https://backend.openbikebox.de/api/resource/1", 
        "identifier": "01", 
        "installed_at": "2021-05-02T08:18:16Z", 
        "modified": "2021-05-02T08:18:16Z", 
        "predefined_dateranges": [
          "day", 
          "week", 
          "month", 
          "year"
        ], 
        "pricegroup": {
          "created": "2021-05-02T08:18:16Z", 
          "fee_day": "1.0000", 
          "fee_hour": "0.2000", 
          "fee_month": "15.0000", 
          "fee_week": "5.0000", 
          "fee_year": "100.0000", 
          "id": 1, 
          "modified": "2021-05-02T08:18:16Z"
        }, 
        "slug": "b1428b07-2bb5-4ae3-a32e-0a7fd48edf1b", 
        "status": "taken", 
        "unavailable_until": "2021-05-25T22:00:00Z"
      }
    ]
  }
}

```

Buchungs-Anfrage:

```json
{
  "predefined_daterange": "day",
  "request_uid": "9170b2e6-b1c7-40da-a20f-3c3c0c366d39",
  "requested_at": "2021-05-24T19:33:08Z",
  "resource_id": 1
}
```

Buchungs-Antwort:

```json
{
  "status": 0,
  "data": {
    "id": 1,
    "created": "2021-05-24T19:33:08Z",
    "modified": "2021-05-24T19:33:08Z",
    "uid": "87004d04-e1d5-4894-8506-4b70a7dc2732",
    "request_uid": "9170b2e6-b1c7-40da-a20f-3c3c0c366d39",
    "session": "PbwiYvIewNXkOgSJq0GaY42SPZVPZlZXp2u2mkhLeH4PjTGokReXPtTK2F274b8n",
    "source": "integration-test",
    "resource_id": 1,
    "location_id": 1,
    "resource_access_id": 1,
    "pricegroup_id": 1,
    "operator_id": 1,
    "requested_at": "2021-05-24T19:33:08Z",
    "valid_till": "2021-05-24T19:34:08Z",
    "begin": "2021-05-24T17:33:08Z",
    "end": "2021-05-25T22:00:00Z",
    "status": "reserved",
    "value_gross": "1.0000",
    "value_net": "0.8403",
    "value_tax": "0.1597",
    "tax_rate": "0.1900",
    "token": [
      {
        "type": "code",
        "identifier": null,
        "secret": "00000",
        "date": "20210525"
      }
    ],
    "resource": {
      "identifier": "01"
    },
    "location": {
      "id": 1,
      "name": "Fahrrad-Station Beispielstadt",
      "slug": "fahrrad-station-beispielstadt",
      "lat": 51.517477,
      "lon": 7.460547
    },
    "operator": {
      "name": "Open Bike GmbH"
    }
  }
}
```
