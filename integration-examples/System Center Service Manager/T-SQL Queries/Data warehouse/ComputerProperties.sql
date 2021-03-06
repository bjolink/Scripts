-- Get computer properties that aren't typically already in SCOM
SELECT 
	computer.OrganizationalUnit,
	owner.DisplayName as 'Custodian',
	statusstring.DisplayName,
	computer.Notes
FROM ComputerDimvw as computer
	INNER JOIN ConfigItemDimvw as ci on computer.EntityDimKey = ci.EntityDimKey
	LEFT OUTER JOIN ConfigItemOwnedByUserFactvw as ownedBy on ci.ConfigItemDimKey = ownedBy.ConfigItemDimKey
	LEFT OUTER JOIN UserDimvw as owner on ownedBy.ConfigItemOwnedByUser_UserDimKey = owner.UserDimKey
	LEFT OUTER JOIN ConfigItemAssetStatusvw as status on ci.AssetStatus_ConfigItemAssetStatusId = status.ConfigItemAssetStatusId
	LEFT OUTER JOIN DisplayStringDimvw as statusString on status.EnumTypeId = statusString.BaseManagedEntityId 
		AND statusString.LanguageCode = 'ENU'
WHERE computer.BaseManagedEntityId = '00000000-0000-0000-0000-000000000000'
