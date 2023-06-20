*** Settings ***
Resource                   ../../../Common.robot
Variables                  ../../../../Tests/Support/LocateUs_Variables.yaml
Resource                   ../../../Excel_Activity.robot
Resource                   ../../../Local_Keywords.robot

*** Keywords ***
UI and Content of 'Store Details' Page Verification
    Confirm UI Elements of Store Page Verification
    Locate Us Search bar and Suggestions Verification of Stores
    MapView Count and ListView Count Verification of Autofetched locations in Stores
    Confirm On Clicking Any Tile user is Redirected to Jio Store Page Verification
    UI and Content of Jio Store Page
    Confirm Redirections of Button on the Jio Store Page Verification 

Confirm UI Elements of Store Page Verification

    #92500
    #Verification of Stores from the top Nav bar
    Wait For And Verify Content                        xpath=//button[@class="j-tab j-tab-size__small active"]    ${StoresTitle_text}
    URL Validation                                     ${locateus_URL}
    Take Page Screenshot                               Support_Redirection_to_Stores

    
    #92501
    Tab Verification    #Covert locators to args
    #Verifying the Stores Container
    ${StoreTiles}=    Get WebElements                  xpath=//section[@data-testid="storeContainer"]
    ${StoreTiles_Length}=    Get Length    ${StoreTiles}
    Log To Console    ${StoreTiles_Length} stores found
    FOR     ${Store_Tile}    IN      @{StoreTiles}
        Scroll To                                      ${Store_Tile}
        Wait For And Verify Element                    ${Store_Tile}
    END

    #Verify Map
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']

    #Footer Verification
    Wait For And Verify Element                        xpath=(//section[@class="j-container l-layout--max-width"])[2]

    #92502 - Verifying if Search Bar is visible
    Wait For And Verify Element                        xpath=//input[@type="search"]

    

Locate Us Search bar and Suggestions Verification of Stores


    #92503
    #Click on Cross button
    Wait For And Click Element                         xpath=//span[@class='input-icon input-icon-suffix clickable']

    #Verifying search field and place holder text
    Wait For And Verify Element                        xpath=//input[@placeholder='Enter your location here'] 

    #Search icon
    Wait For And Verify Element                        xpath=//span[@class="input-icon input-icon-prefix clickable"]


    #92504 TestCase

    #Enter Location
    Wait For And Input Text                            xpath=//input[@placeholder='Enter your location here']    Ujjain
    Sleep    200ms    #Required and Fixed  

    #Check Whether suggestions container apppears
    Wait For And Verify Element                        xpath=//div[@class='sc-jSMfEi hTAndO']    
    
    #92505
    #Clicks on 1st suggested location
    Wait For And Click Element                         xpath=(//div[@class="googleSuggest_suggestion__2-vQO j-text j-text-body-s-bold"])[1] 
    Sleep    2s    #Required and Fixed
    Wait For And Verify Element                        xpath=//section[@role="button"] 

    #92505, 92506 TestCase
    #Verifying Location pin on Map
    ${Store_MapPins}=    Get WebElements               xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${Store_MapPins_Count}=     Get Length     ${Store_MapPins}
    #${Store_MapPins_Count}-1 is written because in map view one icon of searched city is added 
    ${Store_MapPins_Count}=     Evaluate                (${Store_MapPins_Count}-1)
    Log To Console   ${Store_MapPins_Count} Store Mappins found




    #Locations List view
    ${Store_List}=     Get WebElements                 xpath=(//section[@data-testid="storeContainer"])
    ${Store_List_Count}=       Get Length    ${Store_List}
    Log To Console    ${Store_List_Count} Store locations listed

    #Check whether Map view elements and List view elements are same
    IF    ${Store_MapPins_Count} == ${Store_List_Count}
        Log To Console    pass
    ELSE
        Fail
    END


#Check list view and verify each tiles
    FOR  ${ListView_tile_Store}  IN RANGE    1    4        
        
        ${store_status}=     Get Text                  xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Store}] 
        #Text Verification if the store is opened
        IF  "${store_status}" == "OPEN" 
                Text Verification                      xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Store}]    OPEN
                #Stores name verification if opened
                Text Verification                      xpath=(//section[@data-testid="storeContainer"])[${ListView_tile_Store}]    ${store_listview_locations1_text}[${ListView_tile_Store}] 
        #Text Verification if the store is closed
        ELSE     
                Text Verification                      xpath=(//span[@class="j-text j-text-body-xxs-bold"])[${ListView_tile_Store}]    CLOSED 
                #Stores name verification if closed
                Text Verification                      xpath=(//section[@data-testid="storeContainer"])[${ListView_tile_Store}]    ${store_listview_locations2_text}[${ListView_tile_Store}] 
        END 
        #Store working days and timing
        Wait For And Verify Element                    xpath=(//div[@class="listItem_time__9PzyG j-text j-text-body-xs"])[${ListView_tile_Store}]   
    END

    
#92507
MapView Count and ListView Count Verification of Autofetched locations in Stores
    #Refresh page for enabling auto fetch location
    Reload Page
    Sleep    2s     #Required and fixed

    #Verifying whether list view appears after autofetching location  
    Wait For And Verify Element                        xpath=//div[@class="simplebar-content"]

    #Checking the number of Stores in List View
    ${Autofetch_Stores_list}=       Get WebElements    xpath=(//section[@data-testid="storeContainer"]) 
    ${Autofetch_Stores_list_count}=  Get Length           ${Autofetch_Stores_list} 
    Log To Console    ${Autofetch_Stores_list_count} Autofetch Store listview

    

    #Verifying whether map view appears after autofetching location  
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']

    #Checking the number of pins in Map View
    ${Autofetch_Stores_Mappins}=         Get WebElements      xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]   
    ${Autofetch_Stores_Mappins_Count}=    Get Length            ${Autofetch_Stores_Mappins} 
    #${Autofetch_Stores_Mappins_Count}-1 is written because in map view one icon of searched city is added 
    ${Autofetch_Stores_Mappins_Count}=    Evaluate             (${Autofetch_Stores_Mappins_Count}-1)  
    Log To Console    ${Autofetch_Stores_Mappins_Count} Autofetch Store mapview

    #Listview and mapview comparison
    IF     ${Autofetch_Stores_list_count} == ${Autofetch_Stores_Mappins_Count}
        Log To Console    pass
    ELSE
        Fail
    END 

Confirm On Clicking Any Tile user is Redirected to Jio Store Page Verification
    #92508

    Sleep    200ms

    #Click on 1st Tile
    Wait For And Click Element                         xpath=(//section[@role="button"])[1]
    URL Validation                                     ${locateus_URL}

    #JioStore Title verification 
    Wait For And Verify Content                        xpath=//div[@class='storeType']    Jio Store
    Take Page Screenshot                               SC_Store Tile

# Testcase : 92509
UI and Content of Jio Store Page
    # Verifying if Back button is present 
    Wait For And Verify Element                        xpath=//button[@aria-label='button Back']

    # Verifying if Title is present
    Text Verification                                  xpath=//div[@class='storeType']                 Jio Store

    #Title CSS verification
    CSS Verification                                   xpath=//div[@class='storeType']                 font-weight    700 

    # Verifying if Store icon is present
    Wait For And Verify Element                        xpath=//img[@class='storeDescription_headingImage__oAC_N']
    Log To Console                                     icon

    # Verifying if Store image is present
    Wait For And Verify Element                        xpath=//img[@src="https://jep-asset.akamaized.net/jiocom/static/images/jioStore.png"]

    # Verifying if Store address is present
    Scroll To                                          xpath=//button[@aria-label='button Get Directions']
    ${fullAddress} =    Get Text                       xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']    
    Text Verification                                  xpath=//div[@class='storeDescription_address__3t9r8 j-text j-text-body-s']            ${fullAddress}

    # Verifying if Store location icon is present
    Wait For And Verify Element                        xpath=//button[@data-testid="pinnedLocation"]
    
    # Verifying if Store timing is present
    ${Timing} =         Get Text                       xpath=//div[@class='storeDescription_timingsContainer__2r0mI']//div[@class='j-text j-text-body-s']
    Text Verification                                  xpath=//div[@class='storeDescription_timingsContainer__2r0mI']//div[@class='j-text j-text-body-s']            ${Timing}

    #Verifying if the Store is open
    Run Keyword And Return Status    CSS Verification  xpath=//div[@class='storeDescription_openBadgeContainer__bNvty j-badge j-badge-size__small']    background-color    25ab21 
    IF    True
        #If it is green , then the store is open
        Log To Console    Open
    ELSE
        #If it is grey , then the store is closed
        Log To Console    Close
    END  

    # Verifying if Get Directions button is present
    Wait For And Verify Element                        xpath=//button[@aria-label='button Get Directions']
    Text Verification                                  xpath=//button[@aria-label='button Get Directions']     ${locateus_text}[3]

    # Verifying if accurate distance from current location to store location is present
    ${distance} =       Get Text                       xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']
    Text Verification                                  xpath=//div[@class='storeDescription_distance__3iAWP j-text j-text-body-xxs']           ${distance}

    # Verifying if 'Join our best mobile and fiber services from the comfort of your home' is present
    Text Verification                                  xpath=//div[@class="storeDescription_offers__2SzUk"]//div[@class="storeDescription_offerText__1VvhP j-text j-text-body-s"]            ${locateus_text}[2]

    # Verifying if Get Jio SIM button is present
    Wait For And Verify Element                        xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']
    Text Verification                                  xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get Jio SIM']         ${locateus_text}[4]
    
    # Verifying if Get Jio Fiber button is present
    Wait For And Verify Element                        xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']
    Text Verification                                  xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']       ${locateus_text}[5]

    # Verifying if Map view is present
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']
      
#92510
Confirm Redirections of Button on the Jio Store Page Verification
    Scroll To                                          xpath=//div[@class="simplebar-content"]

    #Redirection to Google maps    
    Wait For And Click Element                         xpath=//button[@aria-label='button Get Directions']

    #Click and Get JioSIM link     
    Wait For And Click Element                         xpath=//a[@href="https://www.jio.com/en-in/jio-postpaid-prepaid-home-delivery-book-appointment.html?utm_source=StoreLocator&utm_medium=Banner"]
    Change Tab                                         Get New Jio Sim Card - Best Prepaid and Postpaid Sim Home Delivered 
    Take Page Screenshot                               SC_GetJioSim
    URL Validation                                     ${LocateUs_GetJioSIM_URL}
    Change Tab                                         Locate Us For Nearest Jio Store, Service Center or Hotspot Online

    #Click and Get JioFiber link    
    Wait For And Click Element                         xpath=//a[@class='j-link is-text storeDescription_offerButton__10FTF'][normalize-space()='Get JioFiber']
    Change Tab                                         Get Jio Fiber Connection - New WiFi Connection For Home
    Take Page Screenshot                               SC_GetJioFiber
    URL Validation                                     ${LocateUs_GetJioFiber_URL}
    Change Tab                                         Locate Us For Nearest Jio Store, Service Center or Hotspot Online

    #Back button
    Wait For And Click Element                         xpath=//button[@aria-label='button Back']
     
#92533(part1)
Check List view and Map View are autofetched in Stores
    wait for and Click Element                         xpath=//button[@class="j-tab j-tab-size__small active"]
    
    #------------------------List View -------------------------
    Wait For And Verify Element                        xpath=//div[@class="simplebar-content"]
    #verifying whether list view appears after autofetching location
    Wait For And Verify Element                        xpath=//section[@data-testid="storeContainer"]
    ${storeslistviewtiles}=         Get WebElements    xpath=//section[@data-testid="storeContainer"]
    ${storeslistviewtilescount}=    Get Length         ${storeslistviewtiles}
    Log To Console  ${storeslistviewtilescount} Store listview Autofetch
    
    #-------------------Map View -------------------------
    Wait For And Verify Element                        xpath=//div[@aria-label='Map']
    #verifying whether map view appears after autofetching location
    Wait For And Verify Element                        xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${storesmapviewpins}=           Get WebElements    xpath=//img[@src="https://maps.gstatic.com/mapfiles/transparent.png"]
    ${storesmapviewpinscount}=      Get Length         ${storesmapviewpins}
    #${storesmapviewpinscount}-1 is written because in map view one icon of searched city is added 
    ${storesmapviewpinscount}=      Evaluate           (${storesmapviewpinscount}-1)
    Log To Console   ${storesmapviewpinscount} Store Mapview Autofetch

    #----------listview and mapview comparison---------------
    IF     ${storeslistviewtilescount} == ${storesmapviewpinscount}
        Log To Console    success

    ELSE
        Fail
    END






    
 
  



   
