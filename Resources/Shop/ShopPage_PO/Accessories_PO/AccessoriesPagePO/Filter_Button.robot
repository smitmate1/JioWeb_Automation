*** Settings ***
Resource                              ../../../../Local_Keywords.robot

*** Keywords ***
Checking PriceRange Filter UI
    Click Show Filter Option
    Applying Slider Filter            xpath=(//div[@class="filters-container"])[1]    Price range
    Confirm product list is modified as per "Price filter"
    Remove Filter

Checking Filter Brand UI
    Click Show Filter Option
    ${brand}    Set Variable          Jio
    Applying CheckBox Filter          xpath=(//div[@class="filters-container"])[4]    Brand    ${brand}
    Verify Checkbox Filter            ${brand}
    Remove Filter

Checking Filter Category UI
    Click Show Filter Option
    ${category}    Set Variable       Fiber Accessories
    Applying CheckBox Filter          xpath=(//div[@class="filters-container"])[3]    Category    ${category}
    Verify Checkbox Filter            ${category}
    Remove Filter

Checking Multiple Filter
    Click Show Filter Option
    ${brand}    Set Variable    Jio
    Wait For And Verify Element    //div[@class="slider-container"]/input
    Wait For And Click Element     (//div[@class="slider-container"]/input)[1]
    Drag And Drop By Offset        (//div[@class="slider-container"]/input)[1]     0    0
    Applying CheckBox Filter       xpath=(//div[@class="filters-container"])[4]    Brand    ${brand}
    Wait For And Verify Content    (//li[@class='applied-filtervalue']//a//span)[1]    ${brand}
    ${Filter_Price}=    Get Text   (//li[@class='applied-filtervalue']//a//span)[2]
    Should Contain     ${Filter_Price}    ${max_val}
    Should Contain     ${Filter_Price}    ${min_val}
    Remove Filter