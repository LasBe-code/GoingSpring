package mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Booking;
import model.Business;

public interface AdminMapperAnno {
	
	// 미승인 사업자 목록
	@Select("	SELECT * "
			+ "	FROM (SELECT rownum AS num, business.* FROM business where approval='0') "
			+ "	WHERE num between #{startPage} and #{endPage} "
			+ "	ORDER BY pic_num ")
	List<Business> notApprovalBuList(Map map);
	
	@Select("SELECT count(*) FROM business WHERE approval='0' ")
	int notApprovalBuCount();
	
	@Update("UPDATE business SET approval ='1' WHERE bu_email = #{bu_email} ")
	int businessApproval(String bu_email);
	
	@Delete("DELETE FROM business WHERE bu_email = #{bu_email} ")
	int deleteBusiness(String bu_email);
	
//	사업자 월별 매출
	@Select("select sum(bo.price) price from business bu, booking bo "
			+ " where bu.bu_title = bo.bu_title and bu.bu_email = #{bu_email} and checkin like '____'||#{mon}||'%' ")
	Booking selectSales(Map<String, Object> map);

	
//	지역별 월별 매출
	@Select("select sum(bo.price) price from business bu, booking bo "
			+ "where bu.bu_title = bo.bu_title and bu.bu_address like #{area}||'%' and bo.checkin like '____'||#{month}||'%' ")
	Booking selectAreaSales(Map<String, Object> map);
	
}
