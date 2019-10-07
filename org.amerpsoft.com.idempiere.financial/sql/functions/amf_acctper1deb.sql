﻿-- Function: adempiere.amf_acctper1deb(numeric, numeric, numeric, numeric)

-- DROP FUNCTION adempiere.amf_acctper1deb(numeric, numeric, numeric, numeric);

CREATE OR REPLACE FUNCTION adempiere.amf_acctper1deb(p_client_id numeric, p_org_id numeric, p_account_id numeric, p_period_id numeric)
  RETURNS numeric AS
$BODY$
DECLARE
	v_acctdebperiod	numeric :=0;

BEGIN
		v_acctdebperiod := 0;
	    IF (p_org_id > 0) THEN
			select 
				coalesce(sum(fas.amtacctdr),0.00)  INTO v_acctdebperiod
			FROM
				adempiere.fact_acct as fas
			WHERE
				fas.ad_client_id=p_client_id and fas.ad_org_id=p_org_id and fas.account_id = p_account_id 	
				and (fas.dateacct >= amf_periodstartdate( p_period_id ) and fas.dateacct <= amf_periodenddate( p_period_id ) )
			;
		ELSE
			select 
				coalesce(sum(fas.amtacctdr),0.00)  INTO v_acctdebperiod
			FROM
				adempiere.fact_acct as fas
			WHERE
				fas.ad_client_id=p_client_id  and fas.account_id = p_account_id 
				and (fas.dateacct >= amf_periodstartdate( p_period_id ) and fas.dateacct <= amf_periodenddate( p_period_id ) )
			;
	    END IF;
	   
    	RETURN  v_acctdebperiod;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adempiere.amf_acctper1deb(numeric, numeric, numeric, numeric)
  OWNER TO adempiere;
