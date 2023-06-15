# README
Requirements 


=====================================================================================
Test task - Ruby on Rails
+ Create an endpoint GET /trigger. This endpoint triggers the following procedures in the backend.


1. As a HTTP response it returns current datetime.

2. Stores current datetime in the database, to track when this endpoint was requested last.

3. Sends an event to Redis channel called events, with the help of Sidekiq:

4. Event should contain the datetime (from point no. 2) that was stored in the database during the last /trigger request.

5. Regardless of how often this /trigger endpoint is requested, event has to be published to Redis not more than 1 time per 1 minute.

