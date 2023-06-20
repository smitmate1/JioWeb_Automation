*** Settings ***
Resource    ../Support/SupportPage_PO/LocateUs_PO/RedirectionToLocateUs.robot
Resource    ../Support/SupportPage_PO/LocateUs_PO/ServiceCentres.robot
Resource    ../Support/SupportPage_PO/LocateUs_PO/Hotspot.robot
Resource    ../Support/SupportPage_PO/LocateUs_PO/Stores.robot


*** Keywords ***
Visit LocateUs Support Page of Jio.com
    Landing on Locate Us Page

UI and content Of 'Stores', 'Services Centers' and 'Hotspots' Validation
    UI and Content of 'Store Details' Page Verification
    UI and content of 'service center' page verification
    UI and content of 'Hotspots' Page verification
    Autofetch location content validation

Autofetch location content validation
    Check List view and Map View are autofetched in Stores
    Check List view and Map View are autofetched in Service Centers
    Check List view and Map View are autofetched in Hotspots








    






