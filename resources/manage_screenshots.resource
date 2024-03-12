*** Settings ***
Library            Browser


*** Keywords ***
Take selector Screenshot
    [Documentation]            This keyword takes the screenshot of the selector. 
    ...                        Keyword takes 2 arguments.
    ...                        Provide filename and element selector (for example, id=login-button) as arguments.
    [Arguments]                ${filename}    ${element}
    Browser.Take Screenshot    filename=${CURDIR}${/}../screenshots/${filename}-{index}
    ...                        selector=${element}
    ...                        log_screenshot=True
    ...                        mask=#FF00FF

Take full page screenshot
    [Documentation]            This keyword takes the screenshot of the full webpage and the screenshots are
    ...                        stored in the screenshots folder.
    ...                        Keyword takes 1 arguments.
    ...                        Provide filename as an argument.
    [Arguments]                ${filename}
    Browser.Take Screenshot    filename=${CURDIR}${/}../screenshots/${filename}-{index}
    ...                        selector=${None}
    ...                        fileType=png
    ...                        fullPage=True
    ...                        log_screenshot=True