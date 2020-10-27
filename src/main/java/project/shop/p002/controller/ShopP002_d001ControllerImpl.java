package project.shop.p002.controller;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Pagination;
import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.service.ShopP003_d001Service;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Controller
public class ShopP002_d001ControllerImpl implements ShopP002_d001Controller {
	@Autowired
	ShopP002ShopDetailVO shopP002ShopDetailVO;
	@Autowired
	ShopP002_d001Service shopP002_d001Service;
	@Autowired
	ShopP003_d001Service shopP003_d001Service;
	
	@RequestMapping("/shop/localShopMain.do")
	public String localShopMain(ShopP002ShopDetailVO vo, Model model) {
		return "localShopMain";
	}
	
	@RequestMapping("/shop/localShopSearch.do")
	public String localShopSearch(ShopP002ShopDetailVO vo, Model model) {
		model.addAttribute("usedKeyword",vo.getSearchKeyword());
		model.addAttribute("filter",vo.getFilter());
		return "localShopSearch";
	}
	
	@RequestMapping("/shop/localShopDetail.do")
	public String localShopDetail(ShopP002ShopDetailVO vo, Model model, HttpServletRequest request) {
		if(shopP003_d001Service.loginCheck(request)) {
			HttpSession session = request.getSession(false);
			model.addAttribute("logonId",session.getAttribute("m_id"));
		}else {
			model.addAttribute("logonId","guest");
		}
		model.addAttribute("shopId",vo.getS_id());
		return "localShopDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="/shop/getPopularHashtag.do", produces="text/plain;charset=UTF-8")
	public String getPopularHashtag() {
		return shopP002_d001Service.getPopularHashtag();
	}
	
	@ResponseBody
	@RequestMapping("/shop/getShopDetailByAjax.do")
	public ShopP002ShopDetailVO getShopDetailByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("SEARCHBYSHOPID");
		Map<String,Object> param = new HashMap<>();
		param.put("vo", vo);
		ShopP002ShopDetailVO resultVO = shopP002_d001Service.getShopDetail(param);
		String s_id = resultVO.getS_id();
		List<String> memberIdList = shopP002_d001Service.getMemberIdFromShopReview(s_id);
		int count = memberIdList.size();
		if(count>3) {
			count = 3;
		}
		List<ShopP003ShopReviewVO> reviewList = new ArrayList<>();
		for(int i=0; i<count; i++) {
			ShopP003ShopReviewVO reviewVO = new ShopP003ShopReviewVO();
			reviewVO.setS_id(s_id);
			reviewVO.setM_id(memberIdList.get(i));
			reviewList.add(shopP002_d001Service.getShopReview(reviewVO));
		}
		resultVO.setShopReviewList(reviewList);
		shopP002_d001Service.shopImageEncoder(resultVO);
		for(int i=0; i<resultVO.getShopReviewList().size();i++) {
			shopP002_d001Service.reviewImageEncoder(resultVO.getShopReviewList().get(i));
		}
		return resultVO;
	}
	
	//todo - 가상 페이징 처리
	@ResponseBody
	@RequestMapping("/shop/popularSearchByAjax.do")
	public List<ShopP002ShopDetailVO> popularSearchByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("POPULAR");
		vo.setStatus("REVIEW");
		Map<String,Object> param = new HashMap<>();
		param.put("vo",vo);
		param.put("startIndex",1);
		param.put("endIndex",3);
		List<ShopP002ShopDetailVO> resultList = shopP002_d001Service.getShopList(param);
		for(int i=0; i<resultList.size(); i++) {
			shopP002_d001Service.shopImageEncoder(resultList.get(i));
		}
		return resultList;
	}
	
	@ResponseBody
	@RequestMapping("/shop/searchByAjax.do")
	public Map<String, Object> searchByAjax(@RequestParam(defaultValue="1")int curPage, ShopP002ShopDetailVO vo, Model model) {
		if(vo.getSearchCondition()==null) {
			if(vo.getFilter()==null || vo.getFilter().equals("all") ||  vo.getFilter().equals("")) {
				vo.setSearchCondition("ALLSEARCH");
			}else {
				vo.setSearchCondition("SEARCHBYFILTER");
			}
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		if(vo.getStatus()==null) {
			vo.setStatus("SCORE");
		}
		Map<String,Object> param = new HashMap<>();
		param.put("vo",vo);
		int listCnt = shopP002_d001Service.getShopListCnt(param);
		Pagination pagination = new Pagination(listCnt, curPage, 4);
		param.put("startIndex",(pagination.getStartIndex()+1)+"");
		param.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		List<ShopP002ShopDetailVO> resultList = shopP002_d001Service.getShopList(param);
		for(int i=0; i<resultList.size(); i++) {
			shopP002_d001Service.shopImageEncoder(resultList.get(i));
		}
		Map<String, Object> result = new HashMap<>();
		result.put("resultList", resultList);
		result.put("pagination", pagination);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/shop/shopReviewPopup.do")
	public ShopP003ShopReviewVO shopReviewPopup(ShopP003ShopReviewVO vo, Model model) {
		ShopP003ShopReviewVO resultVO = shopP002_d001Service.getShopReview(vo);
		shopP002_d001Service.reviewImageEncoder(resultVO);
		return resultVO;
	}
	
}
