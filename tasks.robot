*** Settings ***
Library           RPA.Browser.Selenium
Library           zoomer.py

*** Variables ***
@{BROWSERS}       chrome    firefox

*** Keywords ***
Open Site With Selected Browser
    [Arguments]    ${site_url}    ${browser}
    ${status}=    Run Keyword And Return Status
    ...    Open Available Browser
    ...    ${site_url}
    ...    browser_selection=${browser}
    Return From Keyword If    not $status
    Report Browser Window Inner Size
    ${totalzoom}=    Do Some Zooming In and Out
    Log To Console    Total zoom factor for ${browser} was ${totalzoom}
    [Teardown]    Close All Browsers

Do Some Zooming In and Out
    ${totalzoom}=    Set Variable    0
    FOR    ${idx}    IN RANGE    10
        ${zoomfactor}=    Evaluate    random.randint(1,4)
        IF    $idx % 2 == 0
        ${zoomvalue}=    Zooming    up    ${zoomfactor}
        ELSE
        ${zoomvalue}=    Zooming    down    ${zoomfactor}
        END
        ${totalzoom}=    Evaluate    ${totalzoom}+${zoomvalue}
        Report Browser Window Inner Size
        Sleep    2s
    END
    [Return]    ${totalzoom}

Report Browser Window Inner Size
    ${width}    ${height}=    Get Window Size    True
    Log To Console    Window Inner Size ${width}x${height}

*** Tasks ***
Minimal task
    Log To Console    \nTry different browsers and zoom in/out
    FOR    ${browser}    IN    @{BROWSERS}
        Open Site With Selected Browser    https://robocorp.com/docs    ${browser}
    END
    Log    Done.
