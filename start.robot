*** Settings ***
Library  SeleniumLibrary 

*** Keywords ***

*** Variables ***

*** Test Cases ***
Acessar um site
    Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login                 chrome
    Sleep  5
    Input Text  //input[@name="username"]  Admin
    Input Text  //input[@name="password"]  admin123
    Click Element  //button[@class="oxd-button oxd-button--medium oxd-button--main orangehrm-login-button"]
    Sleep  10