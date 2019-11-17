package com.ojakgyo.service;

import com.ojakgyo.domain.LikeVO;

public interface LikeService {

	int likeTotal(String groupCode, int bno);
	int likeCheck(LikeVO like);
	boolean action(LikeVO like);
	boolean cancel(LikeVO like);
}
