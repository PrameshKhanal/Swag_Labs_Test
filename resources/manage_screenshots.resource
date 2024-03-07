*** Settings ***
Library            Browser


*** Keywords ***
Take selector Screenshot
    [Documentation]            Keyword takes 2 arguments.
    ...                        Provide filename and element selector (for example, id=login-button).
    [Arguments]                ${filename}    ${element}
    Browser.Take Screenshot    filename=${SCREENSHOTPATH}/${filename}-{index}
    ...                        selector=${element}
    ...                        log_screenshot=True
    ...                        mask=#FF00FF