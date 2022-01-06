# Gatepass System

## Contents

- [Problem](#problem)
- [Proposed Solution](#proposed-solution)
- [Implementation](#implementation)
  - [ER Diagram](#entity-relatioship-diagram)
- [Screenshots](#screenshots)

A system which focuses on the problems faced by the students who live in hostel.

## Problem

In current system students has to ask the warden of the hostel through a hand written leave application. Students can not leave hostels until warden signs the approve it. There can be a situations when warden can not be present at the seating arrangement, such situations are blows students.

## Proposed Solution

To deal with above problem a possible solution is to digitalise the system. Student asks for leave permission through the digital system, the warden gives permission from the digital system, and the security guards scans the validity of the permission.

A implemented version of this system uses a QR as generated ticket. Each time student requests for permission to leave the a QR code is generated. This QR also expires over time.

## Implementation

### Entity Relatioship Diagram

![ER Diagram](./images/diagram-erd.png)

## Screenshots

### Rector's Panel (Admin Panel)

Add Student

![Rector Adding Student](./images/rector-student-add.png)

View Students

![Rector Viewing Students](./images/rector-students-view.png)

Add Doorkeeper

![Rector Adding Doorkeeper](./images/rector-doorkeeper-add.png)

View Doorkeepers

![Rector Viewing Doorkeepers](./images/rector-doorkeepers-view.png)

Leave Requests

![Interacting with Leave Requests](./images/rector-leave-permission-requests.png)

### Student's Application

<!-- YT VIDEO GOES HERE -->

Login (Before requesting for OTP)

![Login (Before requesting for OTP)](./images/student-login-otp-send.png)

Login (After requesting for OTP)

![Login (After requesting for OTP)](./images/student-login-otp-verify.png)

Home

![Home Screen](./images/student-home.png)

Leave Request

![Requesting for a leave](./images/student-leave-application-form.png)

Leave Request (Status: Approved)

![Leave Approved](./images/student-leave-permission-approved.png)

Leave Request (Status: Rejected)

![Leave Rejected](./images/student-leave-permission-Rejected.png)

### Doorkeeper's Application

Home

![Home Screen](./images/doorkeeper-home.png)

QR Scan

![QR Scan](./images/doorkeeper-qr-scan.png)

Valid QR

![Valid QR](./images/doorkeeper-qr-scan-success.png)

> Rector means Warden
>
> Gatekeeper, Doorkeeper means Security Guard
