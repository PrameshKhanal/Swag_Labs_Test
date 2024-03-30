*** Settings ***
Library            Browser

*** Variables ***


*** Keywords ***
Web page should open successfully
    [Documentation]                    Test to verify that the webpage can be opened and the heading is displayed correctly.
    [Arguments]                        ${URL}
    ...                                ${browser}=chromium    
    ...                                ${headless}=True    
    ...                                ${viewport}={'width': 1920, 'height': 1080}
    Browser.New Browser                browser=${browser}              headless=${headless}
    Browser.New Context                viewport=${viewport}
    Browser.New Page                   ${URL}
    Browser.Wait For Elements State    id=login-button    
    ...                                state=visible    
    ...                                timeout=10s    
    ...                                message=Login button was not visible on the page.
    Browser.Get Url                    assertion_operator=contains     assertion_expected=sauce
    Browser.Get Title                  assertion_operator=should be    assertion_expected=Swag Labs