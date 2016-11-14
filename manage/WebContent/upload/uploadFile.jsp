<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<!-- release v4.3.2, copyright 2014 - 2015 Kartik Visweswaran -->
<html>
<head>
<meta charset="UTF-8" />
<title>Krajee JQuery Plugins - &copy; Kartik</title>
<link href="${pageContext.request.contextPath }/css/all-krajee.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath }/js/fileInput/css/fileinput.css"
	media="all" rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/fileInput/js/fileinput.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/fileInput/js/fileinput_locale_zh.js">
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/artDialog.js?skin=default"></script>
</head>
<style>
body{
	padding-top:10px;
}
.h2{
	margin-left:20px;
	display: inline;
}
.refresh{
	position: absolute;
	right:20px;
	top:10px;
}
</style>
<body>
		<div class="form-group">
			<div class="file-input">
			<div class="file-input file-input-ajax-new">
			<div class="well">
				<h2 class="h2">
				<span class="glyphicon glyphicon-duplicate"></span>查看附件
				</h2>
				<a class="btn btn-primary refresh" href="FileAction_toUploadPage?ownerId=${ownerId }&attachmentType=${attachmentType}" target="_self"><h2><span class="fa fa-refresh"></span></h2></a>
				</div>
				<div class="file-preview">
					<div class=" file-drop-zone">
					<s:if test="existingFiles.size == 0">
						<div class="file-drop-zone-title">(空)</div>
					</s:if>
						<!-- 迭代开始 -->
					<s:iterator value="existingFiles">
						<div class="file-preview-thumbnails">

							<div class="file-preview-frame" id="preview-1463640586390-0"
								data-fileindex="0" title="${fileName }"
								style="width: 160px; height: 160px;">
								<div class="file-preview-other-frame">
									<div class="file-preview-other">
										<span class="file-icon-4x" id="${id }">
											<i class="glyphicon glyphicon-file"></i>
										</span>
										<script>
										function getPreviewIcon(ext,id)
										{
											var $obj = $("#"+id);
											$obj.children().remove();
											
											var retFlag ;
											var self = {
													previewFileIconSettings : {
														'doc' : '<i class="fa fa-file-word-o text-primary"></i>',
														'xls' : '<i class="fa fa-file-excel-o text-success"></i>',
														'ppt' : '<i class="fa fa-file-powerpoint-o text-danger"></i>',
														'jpg' : '<img src="${url}" />',
														'pdf' : '<i class="fa fa-file-pdf-o text-danger"></i>',
														'zip' : '<i class="fa fa-file-archive-o text-muted"></i>',
														'htm' : '<i class="fa fa-file-code-o text-info"></i>',
														'txt' : '<i class="fa fa-file-text-o text-info"></i>',
														'mov' : '<i class="fa fa-file-movie-o text-warning"></i>',
														'mp3' : '<i class="fa fa-file-audio-o text-warning"></i>',
													},
													previewFileExtSettings : {
														'doc' : function(ext) {
															return ext.match(/(doc|docx)$/i);
														},
														'xls' : function(ext) {
															return ext.match(/(xls|xlsx)$/i);
														},
														'ppt' : function(ext) {
															return ext.match(/(ppt|pptx)$/i);
														},
														'jpg' : function(ext) {
															return ext.match(/(jp?g|png|gif|bmp)$/i);
														},
														'zip' : function(ext) {
															return ext.match(/(zip|rar|tar|gzip|gz|7z)$/i);
														},
														'htm' : function(ext) {
															return ext.match(/(php|js|css|htm|html)$/i);
														},
														'txt' : function(ext) {
															return ext.match(/(txt|ini|md)$/i);
														},
														'mov' : function(ext) {
															return ext.match(/(avi|mpg|mkv|mov|mp4|3gp|webm|wmv)$/i);
														},
														'mp3' : function(ext) {
															return ext.match(/(mp3|wav)$/i);
														},
													}
													}
													//匹配 出 doc、docx 为同一对应图标 
													 $.each(self.previewFileExtSettings, function (key, func) {
											             if (self.previewFileIconSettings[key] && func(ext)) {
											            	 retFlag = (self.previewFileIconSettings[key]);
											             }
											         });
									         if(typeof(retFlag) == "undefined")
										     {
									        	 retFlag = 	"<i class='glyphicon glyphicon-file'></i>";
										     }
							        		$obj.append(retFlag);
							        		return retFlag;
										}
										getPreviewIcon("${extName}","${id}");
										</script>
									</div>
								</div>
								<div class="file-preview-other-footer">
									<div class="file-thumbnail-footer">
										<div class="file-footer-caption" title="${fileName }">${fileName }</div>
										<div class="file-thumb-progress hide">
											<div class="progress"></div>
										</div>
										<div class="file-actions">
											<div class="file-footer-buttons">
												<a type="button" href="${pageContext.request.contextPath }/FileAction_download?id=${id}"
													class="kv-file-upload btn btn-xs btn-default" title="下载文件">
													<i class="glyphicon glyphicon-download text-info"></i>
												</a>
												<a type="button" href="${pageContext.request.contextPath }/FileAction_deleteExistingFileByFileId?id=${id}"
													class="deleteFile kv-file-remove btn btn-xs btn-default" title="删除文件">
													<i class="glyphicon glyphicon-trash text-danger"></i>
												</a>
											</div>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</s:iterator>

						<!-- 迭代结束-->
						<div class="clearfix"></div>
					</div>
				</div>
</div>
			</div>
		</div>

	<form enctype="multipart/form-data">
	<div class="well"><h2 class="h2"><span class="fa fa-send"></span>上传附件</h2></div>
		<div class="form-group">
			<input id="file-ready" name="file" class="file" type="file" multiple
				data-preview-file-type="any"
				data-upload-url="FileAction_uploadFile?ownerId=${ownerId }&attachmentType=${attachmentType}">
		</div>
	</form>

</body>
<script>
	$("#file-ready").fileinput({
		'showPreview' : true,
		/* 初始化上传的文件         'initialPreview' : "aaaa", */
		'elErrorContainer' : '#errorBlock',
		language : 'zh',
		maxFilePreviewSize : 500000,
		previewFileIconSettings : {
			'doc' : '<i class="fa fa-file-word-o text-primary"></i>',
			'xls' : '<i class="fa fa-file-excel-o text-success"></i>',
			'ppt' : '<i class="fa fa-file-powerpoint-o text-danger"></i>',
			'jpg' : '<i class="fa fa-file-photo-o text-warning"></i>',
			'pdf' : '<i class="fa fa-file-pdf-o text-danger"></i>',
			'zip' : '<i class="fa fa-file-archive-o text-muted"></i>',
			'htm' : '<i class="fa fa-file-code-o text-info"></i>',
			'txt' : '<i class="fa fa-file-text-o text-info"></i>',
			'mov' : '<i class="fa fa-file-movie-o text-warning"></i>',
			'mp3' : '<i class="fa fa-file-audio-o text-warning"></i>',
		},
		previewFileExtSettings : {
			'doc' : function(ext) {
				return ext.match(/(doc|docx)$/i);
			},
			'xls' : function(ext) {
				return ext.match(/(xls|xlsx)$/i);
			},
			'ppt' : function(ext) {
				return ext.match(/(ppt|pptx)$/i);
			},
			'jpg' : function(ext) {
				return ext.match(/(jp?g|png|gif|bmp)$/i);
			},
			'zip' : function(ext) {
				return ext.match(/(zip|rar|tar|gzip|gz|7z)$/i);
			},
			'htm' : function(ext) {
				return ext.match(/(php|js|css|htm|html)$/i);
			},
			'txt' : function(ext) {
				return ext.match(/(txt|ini|md)$/i);
			},
			'mov' : function(ext) {
				return ext.match(/(avi|mpg|mkv|mov|mp4|3gp|webm|wmv)$/i);
			},
			'mp3' : function(ext) {
				return ext.match(/(mp3|wav)$/i);
			},
		}

	}).on("fileuploaded",function(){
		//window.location.reload();
	});

	
	$(".deleteFile").click(function(){
		var url = this.href;
		var $obj = $(this);
		var args = {"time" : new Date()};
		art.dialog({
			content: '确定要删除这个附件吗',
			ok: function () {
				$.getJSON(url, args, function(data){
					if(data.flag == 1){
						$obj.parent().parent().parent().parent().parent().parent().fadeOut();
					}
					else{
						art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'删除失败！', ok:true,});
					}
				});
				return true;
			},
			cancel: true,
			lock:true,
		});
		return false;
	});
</script>
</html>