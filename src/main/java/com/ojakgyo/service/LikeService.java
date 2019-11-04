package com.ojakgyo.service;

import com.ojakgyo.domain.LikeVO;

public interface LikeService {

	int likeTotal(String groupCode, int bno);
	int likeCheck(String groupCode, LikeVO like);
	boolean action(String groupCode, LikeVO like);
	boolean cancel(String groupCode, LikeVO like);
}
