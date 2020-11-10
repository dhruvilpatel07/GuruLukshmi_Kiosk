# Customer Side UI 

## What does this app do?
- This app has to 2 UI one for customers to place order and one dashboard [(Click here for more info on dashboard)](https://github.com/dhruvilpatel07/GuruLukshmi_DashBoard) for staff/kitchen side/admin 
- App uses Firebase to listen to live updates of database and updates dashboard side when ever the new order is placed in resturant
- At the begining of shifts staff members logs in to customer side UI to select if the current iPad is going to be used for take-out or dine-in
- If it's dine-in then select which table is that iPad is allocated to (to display table number in database and display it in dashboard to serve customer)

## Technologies / Libraries used to create this project 
- Xcode
- Swift/SwiftUI
- PayPal
- Firebase
- SceneKit
- [MailCore2](https://github.com/MailCore/mailcore2)

## Here are some screenshots of app 

### Login View to select if it's for take-out or dine-in both has different login info 
![](Images/img8.png)

### If you login to use us dine-in select table
![](Images/img6.png)

### To place order view
![](Images/img1.png)
![](Images/img7.png)
![](Images/img2.png)

### Upon placing order it will rediret user to PayPal payment gateway to take payments (More payment options will be added in future)
![](Images/img3.png)
![](Images/img4.png)

### After successful payment app will send the email reciept with custom pdf attactment automatically using MailCore2
![](Images/img5.png)




