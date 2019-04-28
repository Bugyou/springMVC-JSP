package com.tgb.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Files {
	private List<MultipartFile> multipartFiles;
	private MultipartFile[] files;

	public List<MultipartFile> getMultipartFiles() {
		return multipartFiles;
	}

	public void setMultipartFiles(List<MultipartFile> multipartFiles) {
		this.multipartFiles = multipartFiles;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}	
}
