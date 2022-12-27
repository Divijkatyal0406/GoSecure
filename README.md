# GoSecure


<h1 align="center"><img width=20% height=50% alt="SheHeroes" src="https://github.com/Divijkatyal0406/GoSecure/blob/master/GoSecure-logos-modified%20(2).png"></h1>

<h1 align="center">🅶🅾🆂🅴🅲🆄🆁🅴 - Women Safety App</h1>
<!--[![All Contributors](https://img.shields.io/badge/all_contributors-04-orange.svg?style=flat-square)](#contributors-)-->

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<p align="center">
 <img src="https://github.com/Divijkatyal0406/CrowdQuest/blob/resolved/images/banner.png" width="90%" height="400" />
</p>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<h2 align="center" id="Inspiration"> :label: Inspiration</h2>

Considering the importance of safety and security of women in India, I wanted to give it a try from my end to address the issue in a simpler and safer way. The app is about safety as well as awareness & makes the user safe & confident. It is easy to use because of it's user friendly and easy to navigate UI. I wanted to give them a tap on the shoulder to keep going and not give up! 
<br>
Keeping this mind I developed an application named <b>GoSecure</b>.


![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

<br>

<h2 align="center" id="TechStack"> :label: Tech Stack

```diff
+ Flutter +
+ Dart +
+ Google Map Api +
+ CrimeoMeter Api +
+ Shared Preferences +
+ SMS Manager API +
+ Sensor Manager API +
+ Background Service +
+ Media player api +
```
</h2>

<br>



![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## 🔗 Links for project:  
 
Download APK : here

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## 🚩 Features and Interfaces:
Feature | Images
------------ | -------------
 **Dashboard**  
 It is fast, easy to use, and incredibly convenient with a minimalistic UI! | ![homepage](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/home.png)
**Scream Alert** 
Detects human scream to send alerts to saved contacts!|![registrationPage](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/c_dashboard.png)
**Go Nirbhaya**
Sends journey alerts periodically with the loved ones! |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/t_dashboard.png)
**Emergency contacts**
Users are provided with various women emergency helplines on their fingertips |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/question_submit.png)
**Safety Pin**
User can set the pin which can be used to turn off the SOS and send info about false alert |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/discuss.png)
**LiveSafe**
Finds and guides user to nearest police stations, hospitals and bus stations |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/ocr.png)
**Spy Cam Detector**
Uses magnetometer sensors of the phone to detect any potencial active camera around! |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/virtual.png)
**Articles**
Various motivational articles for women |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/multi.png)
**Self defence**
Self Defence techniques to empower women! |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/sample.png)
**Fake Call**
Fake call generator to get out of suspectful situaltion |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/discuss.png)
**Shake Detector**
Shake frequency detector to send alerts |![professor](https://github.com/Divijkatyal0406/CrowdQuest/blob/master/images/discuss.png)



![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## 🚩Installation/Environment Setup 

  #### Login Credentials 
       Username - "Divij" password - "divij0406" passcode - "123456"
       Ethereum address - "0xED620CdD26E4adfae79Ea12f5fadd2c4c6ab54a4"
       
  #### 1. Clone App
  
  * Write the following command and press enter.
  
  ```
    $ git clone https://github.com/Divijkatyal0406/CrowdQuest.git
  ```
    
 #### 2. Install node packages
  * Move to the parent/root directory (CrowdQuest) cd CrowdQuest
  * Write the following command and press enter to download all required node modules.
 
   ```
   $ cd CrowdQuest
   $ npm install 
  ```
  
#### 3. Ganache
  - Open Ganache and click on settings in the top right corner.
  - Under **Server** tab:
    - Set Hostname to 127.0.0.1 -lo
    - Set Port Number to 8545
    - Enable Automine
  - Under **Accounts & Keys** tab:
    - Enable Autogenerate HD Mnemonic

#### 4. IPFS
  - Fire up your terminal and run `ipfs init`
  - Then run 
    ```
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "['*']"
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials "['true']"
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "['PUT', 'POST', 'GET']"
    ```

    > Note: If you face any issues with the above command on windows, try using command prompt and escape sequences or git bash.
#### 5. Metamask
  - After installing Metamask, click on the metamask icon on your browser.
  - Click on __TRY IT NOW__, if there is an announcement saying a new version of Metamask is available.
  - Click on continue and accept all the terms and conditions after reading them.
  - Stop when Metamask asks you to create a new password. We will come back to this after deploying the contract in the next section.
  
#### 6. Smart Contract

1. Install Truffle using `npm install truffle -g`
2. Compile Contracts using `truffle compile`

#### 7. Starting your local development blockchain
  - Open Ganache.
  - Make sure to configure it the way mentioned above.
    7.1. Open new Terminal and deploy contracts using `truffle migrate`

#### 8. Local server

1. Install Node lite-server by running the following command on your terminal `npm install -g lite-server`

#### 9. Run Locally
  * Move back to the parent directory by cd..
  * While you are still inside the cloned folder, write the following command to run the website locally.
 
 ```
   $ npm run dev
 ```
 
 
 ###### NOTE: After performing all the steps give a few seconds for frontend to load and the port by default will be ```http://localhost:3000/```
