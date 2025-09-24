/*
 * IBM Confidential
 * OCO Source Materials
 * 5737-M66, 5900-AAA, 5900-AMG
 * (C) Copyright IBM Corp. 2021, 2024
 * The source code for this program is not published or otherwise divested of
 * its trade secrets, irrespective of what has been deposited with the U.S.
 * Copyright Office.
 */
package psdi.app.bim.viewer.lmv.util;

import static org.junit.Assert.assertEquals;


import org.junit.Test;

import psdi.app.bim.viewer.lmv.test.util.SampleTestData;
import psdi.app.bim.viewer.lmv.test.util.TestConstants;
import psdi.security.UserInfo;
import psdi.security.UserInfoMocker;
import psdi.test.FastUnitTestBase;

public class LMVQueryUtilTest extends FastUnitTestBase {
	public static final String COPYRIGHT = "(C) Copyright IBM Corp. 2021, 2024 All Rights Reserved.\n";
	
	public static final String GET_ASSET_MARKUPS_WHERE_CLAUSE_SAMPLE = "buildingmodelid= 'mockModelId'  and siteid= 'mockAssetNumber'   and assetnum =  'mockSiteId'  AND viewerState like '%eyJzZWVkVVJOIjoiZFhKdU9tRmtjMnN1YjJKcVpXTjBjenB2Y3k1dlltcGxZM1E2ZDJsdVpHOTNjekl5ZEd4eWRIZGhjR3RsYldGamJUWnFabkJtTm1kdWIybHRaM2gyWlc5dFlYUXZaWGhsWTNWMGFYWmxZbkpwWldacGJtZGpaVzUwWlhKeUxuSjJkQSIsIm9iamVjdFNldCI6W3siaWQiOls0Mzc2XSwiaXNvbGF0ZWQiOltdLCJoaWRkZW4iOltdLCJleHBsb2RlU2NhbGUiOjAsImlkVHlwZSI6ImxtdiJ9XSwidmlld3BvcnQiOnsibmFtZSI6IiIsImV5ZSI6Wy0yNi40Nzc0OTAwMzc0MzE5NzMsLTI2LjA2MTM5MDg2NjE5MDk3MywtMS4wMzMxOTQ2OTY5MDAzNDQzXSwidGFyZ2V0IjpbLTI2LjQ3ODE3MzI1NTkyMDQxLC0yNy4wMzUyNjIxMDc4NDkxMiwtMS4zMTY4NDA3Njc4NjA0MTI2XSwidXAiOlstMC4wMDAxOTYxNzg4NjI0ODYzMzgwMiwtMC4yNzk2MzY2ODM3Njk4NDE4LDAuOTYwMTA1ODcyNjAxNTg5M10sIndvcmxkVXBWZWN0b3IiOlswLDAsMV0sInBpdm90UG9pbnQiOlstMjYuNDc4MTczMjU1OTIwNDEsLTI3LjAzNTI2MjEwNzg0OTEyLC0xLjMxNjg0MDc2Nzg2MDQxMjZdLCJkaXN0YW5jZVRvT3JiaXQiOjEuMDE0MzM3NTk0NTM1MTU4MywiYXNwZWN0UmF0aW8iOjIuOTc5ODQ4ODY2NDk4NzQwNCwicHJvamVjdGlvbiI6Im9ydGhvZ3JhcGhpYyIsImlzT3J0aG9ncmFwaGljIjp0cnVlLCJvcnRob2dyYXBoaWNIZWlnaHQiOjEuMDE0MzM3NTk0NTM1MTU4M30sInJlbmRlck9wdGlvbnMiOnsiZW52aXJvbm1lbnQiOiJQbGF6YSIsImFtYmllbnRPY2NsdXNpb24iOnsiZW5hYmxlZCI6dHJ1ZSwicmFkaXVzIjoxMCwiaW50ZW5zaXR5IjoxfSwidG9uZU1hcCI6eyJtZXRob2QiOjEsImV4cG9zdXJlIjotMTQsImxpZ2h0TXVsdGlwbGllciI6LTFlLTIwfSwiYXBwZWFyYW5jZSI6eyJnaG9zdEhpZGRlbiI6dHJ1ZSwiYW1iaWVudFNoYWRvdyI6dHJ1ZSwiYW50aUFsaWFzaW5nIjp0cnVlLCJwcm9ncmVzc2l2ZURpc3BsYXkiOnRydWUsInN3YXBCbGFja0FuZFdoaXRlIjpmYWxzZSwiZGlzcGxheUxpbmVzIjp0cnVlLCJkaXNwbGF5UG9pbnRzIjp0cnVlfX0sImN1dHBsYW5lcyI6W119%'";
	
	public static final String GET_LOCATION_MARKUPS_WHERE_CLAUSE_SAMPLE = "buildingmodelid= 'mockModelId'  and siteid= 'mockAssetNumber'   and assetnum =  'mockSiteId'  AND viewerState like '%eyJzZWVkVVJOIjoiZFhKdU9tRmtjMnN1YjJKcVpXTjBjenB2Y3k1dlltcGxZM1E2ZDJsdVpHOTNjekl5ZEd4eWRIZGhjR3RsYldGamJUWnFabkJtTm1kdWIybHRaM2gyWlc5dFlYUXZaWGhsWTNWMGFYWmxZbkpwWldacGJtZGpaVzUwWlhKeUxuSjJkQSIsIm9iamVjdFNldCI6W3siaWQiOls0Mzc2XSwiaXNvbGF0ZWQiOltdLCJoaWRkZW4iOltdLCJleHBsb2RlU2NhbGUiOjAsImlkVHlwZSI6ImxtdiJ9XSwidmlld3BvcnQiOnsibmFtZSI6IiIsImV5ZSI6Wy0yNi40Nzc0OTAwMzc0MzE5NzMsLTI2LjA2MTM5MDg2NjE5MDk3MywtMS4wMzMxOTQ2OTY5MDAzNDQzXSwidGFyZ2V0IjpbLTI2LjQ3ODE3MzI1NTkyMDQxLC0yNy4wMzUyNjIxMDc4NDkxMiwtMS4zMTY4NDA3Njc4NjA0MTI2XSwidXAiOlstMC4wMDAxOTYxNzg4NjI0ODYzMzgwMiwtMC4yNzk2MzY2ODM3Njk4NDE4LDAuOTYwMTA1ODcyNjAxNTg5M10sIndvcmxkVXBWZWN0b3IiOlswLDAsMV0sInBpdm90UG9pbnQiOlstMjYuNDc4MTczMjU1OTIwNDEsLTI3LjAzNTI2MjEwNzg0OTEyLC0xLjMxNjg0MDc2Nzg2MDQxMjZdLCJkaXN0YW5jZVRvT3JiaXQiOjEuMDE0MzM3NTk0NTM1MTU4MywiYXNwZWN0UmF0aW8iOjIuOTc5ODQ4ODY2NDk4NzQwNCwicHJvamVjdGlvbiI6Im9ydGhvZ3JhcGhpYyIsImlzT3J0aG9ncmFwaGljIjp0cnVlLCJvcnRob2dyYXBoaWNIZWlnaHQiOjEuMDE0MzM3NTk0NTM1MTU4M30sInJlbmRlck9wdGlvbnMiOnsiZW52aXJvbm1lbnQiOiJQbGF6YSIsImFtYmllbnRPY2NsdXNpb24iOnsiZW5hYmxlZCI6dHJ1ZSwicmFkaXVzIjoxMCwiaW50ZW5zaXR5IjoxfSwidG9uZU1hcCI6eyJtZXRob2QiOjEsImV4cG9zdXJlIjotMTQsImxpZ2h0TXVsdGlwbGllciI6LTFlLTIwfSwiYXBwZWFyYW5jZSI6eyJnaG9zdEhpZGRlbiI6dHJ1ZSwiYW1iaWVudFNoYWRvdyI6dHJ1ZSwiYW50aUFsaWFzaW5nIjp0cnVlLCJwcm9ncmVzc2l2ZURpc3BsYXkiOnRydWUsInN3YXBCbGFja0FuZFdoaXRlIjpmYWxzZSwiZGlzcGxheUxpbmVzIjp0cnVlLCJkaXNwbGF5UG9pbnRzIjp0cnVlfX0sImN1dHBsYW5lcyI6W119%'";
	
    @Test
    public void testGetSavedViewsWhereClause() throws Exception {
    	
		String expectedWhereQuery = "buildingmodelid= 'mockModelId'  and siteid= 'mockSiteId'  and ( owner=:3 or shared= 1 )and identifier= 'mockIdentifier' ";
		
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);

		String actualWhereQuery = LMVQueryUtil.getSavedViewsWhereClause(userInfo, "mockModelId", "mockSiteId", "mockIdentifier");
		
		assertEquals("getSavedViewsWhereClause is not expected", expectedWhereQuery, actualWhereQuery); 
		
    }
    
    @Test
    public void testGetSavedViewsWhereClauseWithEmptyIdentifer() throws Exception {
    	
		String expectedWhereQuery = "buildingmodelid= 'mockModelId'  and siteid= 'mockSiteId'  and ( owner=:3 or shared= 1 )and identifier is null";
		
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);

		String actualWhereQuery = LMVQueryUtil.getSavedViewsWhereClause(userInfo, "mockModelId", "mockSiteId", "");
		
		assertEquals("getSavedViewsWhereClause is not expected", expectedWhereQuery, actualWhereQuery); 
		
    }
    
    @Test
    public void testGetAssetMarkupsWhereClause() throws Exception {

		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);

		String actualWhereQuery = LMVQueryUtil.getAssetLocationMarkupsWhereClause(userInfo, "mockModelId", "mockSiteId", "mockAssetNumber", true, SampleTestData.SAMPLE_ENCODED_VIEWER_STATE);
		
		assertEquals("getAssetMarkupsWhereClause is not expected", GET_ASSET_MARKUPS_WHERE_CLAUSE_SAMPLE, actualWhereQuery); 
		
    }
    
    @Test
    public void testGetLocationaMarkupsWhereClause() throws Exception {
		
		UserInfo userInfo = UserInfoMocker.mockUserInfo(TestConstants.LOCALE_AR);

		String actualWhereQuery = LMVQueryUtil.getAssetLocationMarkupsWhereClause(userInfo, "mockModelId", "mockSiteId", "mockAssetNumber", true, SampleTestData.SAMPLE_ENCODED_VIEWER_STATE);
		
		assertEquals("getLocationMarkupsWhereClause is not expected", GET_LOCATION_MARKUPS_WHERE_CLAUSE_SAMPLE, actualWhereQuery); 
		
    }

}
