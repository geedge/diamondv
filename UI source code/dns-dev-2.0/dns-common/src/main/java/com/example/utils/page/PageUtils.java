/**

 *

 *
 *
 */

package com.example.utils.page;



import com.baomidou.mybatisplus.core.metadata.IPage;

import java.io.Serializable;
import java.util.List;

/**
 * 分页工具类
 *
 * @author Mark sunlightcs@gmail.com
 */
public class PageUtils implements Serializable {
	private static final long serialVersionUID = 1L;
	/**
	 * 总记录数
	 */
	private int total;
	/**
	 * 每页记录数
	 */
	private int size;
	/**
	 * 总页数
	 */
	private int pages;
	/**
	 * 当前页数
	 */
	private int page;
	/**
	 * 列表数据
	 */
	private List<?> list;

	private double totalTime;

	private Object independentIpNum;

	private int resultTotal;

	public int getResultTotal() {
		return resultTotal;
	}

	public void setResultTotal(int resultTotal) {
		this.resultTotal = resultTotal;
	}

	/**
	 * 分页
	 * @param list        列表数据
	 * @param total  总记录数
	 * @param size    每页记录数
	 * @param page    当前页数
	 */
	public PageUtils(List<?> list, int total, int size, int page ,double totalTime,int independentIpNum ,int resultTotal) {
		this.list = list;
		this.total = total;
		this.size = size;
		this.page = page;
		this.totalTime = totalTime;
		this.independentIpNum = independentIpNum;
		this.resultTotal = resultTotal;
		this.pages = (int)Math.ceil((double)total/size);
	}

	/**
	 * 分页
	 */
	public PageUtils(IPage<?> page) {
		this.list = page.getRecords();
		this.total = (int)page.getTotal();
		this.size = (int)page.getSize();
		this.page = (int)page.getCurrent();
		this.pages = (int)page.getPages();
	}


	public Object getIndependentIpNum() {
		return independentIpNum;
	}

	public void setIndependentIpNum(Object independentIpNum) {
		this.independentIpNum = independentIpNum;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getPages() {
		return pages;
	}

	public void setPages(int pages) {
		this.pages = pages;
	}

	public int getPage() {
		return page;
	}

	public double getTotalTime() {
		return totalTime;
	}

	public void setTotalTime(double totalTime) {
		this.totalTime = totalTime;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}
}
