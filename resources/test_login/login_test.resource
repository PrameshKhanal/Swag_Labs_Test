*** Settings ***
Library            Browser
Library            String

Resource           suite_management${/}manage_screenshots.resource

*** Keywords ***
Login With Standard User
    Browser.Type Text                                       id=user-name    standard_user
    Browser.Type Text                                       id=password     secret_sauce
    Browser.Click                                           id=login-button
    Browser.Wait For Elements State                         css=select.product_sort_container    visible    timeout=5s

Verify Login button
    [Documentation]                                         This test case will verify that the Login button is not disabled and after verification,
    ...                                                     this test case will take the screenshot of the Login button.
    [Tags]                                                  loginButtonTest
    Browser.Get Attribute                                   id=login-button
    ...                                                     attribute=aria-disabled    
    ...                                                     assertion_operator=should be    
    ...                                                     assertion_expected=${None}
    manage_screenshots.Take selector Screenshot             login_test    id=login-button

Verify Empty Credentials Login
    [Documentation]                                         This test will verify that the error message will be displayed if empty username and password
    ...                                                     is provided and login button is selected.
    [Tags]                                                  errorMsgTest
    Browser.Wait For Elements State                         xpath=//*[@id="login_button_container"]/div/form/div[3]/h3/text()    hidden    
    ...                                                     message=The error message is displayed before Login button is pressed!
    Browser.Click                                           id=login-button
    Browser.Get Element States                              xpath=//*[@id="login_button_container"]/div/form/div[3]/h3/text()    ==    detached
    manage_screenshots.Take full page screenshot            swaglablogin

Verify Valid Credentials Login
    [Documentation]                                         This test will verify that only certain users can login using the username and password
    ...                                                     provided in the webpage. If the user cannot login, test will take screenshot of the login
    ...                                                     screen where the error message is highlighted.
    [Tags]                                                  loginTest
    ${usernamelements}                                      Browser.Get Text    css=\#login_credentials
    ${usernames}                                            String.Split String    ${usernamelements}    \n
    ${passwordelements}                                     Browser.Get Text    css=div.login_password
    ${passwords}                                            String.Split String    ${passwordelements}    \n
    FOR    ${index}    IN RANGE    1    6
        Browser.Type Text                                   id=user-name    ${usernames}[${index}]
        Browser.Type Text                                   id=password     ${passwords}[1]
        Browser.Click                                       id=login-button
        TRY
            Browser.Wait For Elements State                 text=Products    visible    timeout=10s    message=The product page was not visible!
            Log                                             User ${usernames}[${index}] was able to login!
            Browser.Click                                   id=react-burger-menu-btn
            Browser.Wait For Elements State                 id=logout_sidebar_link    visible    timeout=5s
            Browser.Click                                   id=logout_sidebar_link
            Browser.Wait For Elements State                 id=login-button    visible    timeout=10s
        EXCEPT    The product page was not visible!
            Log                                             User ${usernames}[${index}] was not able to login!
            manage_screenshots.Take full page screenshot    invalid_login
        END
    END