*** Settings ***
Documentation            Robot Framework tests to verify the features of the Swags Lab demo site.

Library                  Browser

Resource                 ../resources/browser_login.resource
Resource                 ../resources/manage_screenshots.resource

Suite Setup              browser_login.Web page should open successfully    ${URL}
Suite Teardown           Browser.Close Browser    browser=ALL


*** Variables ***
${URL}                   https://www.saucedemo.com/


*** Test Cases ***
Login button should exist
    [Documentation]                                This test case will verify that the Login button is not disabled and after verification,
    ...                                            this test case will take the screenshot of the Login button.
    [Tags]                                         loginButtonTest
    Browser.Get Attribute                          id=login-button
    ...                                            attribute=aria-disabled    
    ...                                            assertion_operator=should be    
    ...                                            assertion_expected=${None}
    manage_screenshots.Take selector Screenshot    login_test    id=login-button

Error message should be visible for empty username & password
    [Documentation]                                This test will verify that the error message will be displayed if empty username and password
    ...                                            is provided and login button is selected.
    [Tags]                                         errorMsgTest
    Browser.Wait For Elements State                xpath=//*[@id="login_button_container"]/div/form/div[3]/h3/text()    hidden    
    ...                                            message=The error message is displayed before Login button is pressed!
    Browser.Click                                  id=login-button
    Browser.Get Element States                     xpath=//*[@id="login_button_container"]/div/form/div[3]/h3/text()    ==    detached
    manage_screenshots.Take full page screenshot    swaglablogin
    
*** Keywords ***
