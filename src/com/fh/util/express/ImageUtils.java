package com.fh.util.express;

import com.fh.util.Const;
import com.fh.util.Tools;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;



/**图片工具类   
 * @ClassName:     ImageUtils   
 * @Description:   TODO(图片工具类)   
 * @author:        Ajie
 * @date:          2019年9月18日 上午11:16:04     
 */
public class ImageUtils {
	

	
	/**上传图片   
	 * @Title:         upload   
	 * @Description:   TODO(上传图片)   
	 * @param:         @param request
	 * @param:         @param pictureFile    
	 * @return:        String 图片路径  
	 * @author:        Ajie  
	 * @date:          2019年9月18日 上午11:16:52   
	 */
	public static String upload(HttpServletRequest request, MultipartFile pictureFile) throws IOException {
		String imgPath = null;// 装配后的图片地址
		// 上传图片
		if (pictureFile != null && !pictureFile.isEmpty()) {
			// 使用UUID给图片重命名，并去掉四个“-”
			String name = UUID.randomUUID().toString().replaceAll("-", "");
			// 获取文件的扩展名
			String ext = FilenameUtils.getExtension(pictureFile.getOriginalFilename());
			if (Tools.isEmpty(ext)) {
				ext = "jpg";
			}
			// 设置图片上传路径
			String url = request.getSession().getServletContext().getRealPath(Const.FILEPATHIMG);
			// 检验文件夹是否存在
			isFolderExists(url);
			// 以绝对路径保存重名命后的图片
			pictureFile.transferTo(new File(url + "/" + name + "." + ext));
			// 装配图片地址
			imgPath = Const.FILEPATHIMG + name + "." + ext;
		}
		return imgPath;
	}
	
	/**验证文件夹是否存在   
	 * @Title:         isFolderExists   
	 * @Description:   TODO(验证文件夹是否存在) 
	 * @return:        boolean   
	 * @author:        Ajie  
	 * @date:          2019年9月18日 上午11:17:50 
	 */
	public static boolean isFolderExists(String strFolder) {
		File file = new File(strFolder);
		if (!file.exists()) {
			if (file.mkdir()) {
				return true;
			} else {
				return false;
			}
		}
		System.out.println("-----------------文件上传路径：" + strFolder);
		return true;
	}
	
	/**获取目录下所有文件(按时间排序)   
	 * @Title:         getFileSort   
	 * @Description:   TODO(获取目录下所有文件(按时间排序)   
	 * @param:         @param path   
	 * @return:        List<File>   
	 * @author:        Ajie  
	 * @date:          2019年9月18日 上午11:18:38   
	 * @throws   
	 */
	public static List<File> getFileSort(String path) {
		List<File> list = getFiles(path, new ArrayList<File>());
		if (list != null && list.size() > 0) {
			Collections.sort(list, new Comparator<File>() {
				public int compare(File file, File newFile) {
					if (file.lastModified() < newFile.lastModified()) {// 降序<;升序>
						return 1;
					} else if (file.lastModified() == newFile.lastModified()) {
						return 0;
					} else {
						return -1;
					}
				}
			});
		}
		return list;
	}

	/**获取目录下所有文件   
	 * @Title:         getFiles   
	 * @Description:   TODO(获取目录下所有文件)  
	 * @return:        List<File>   
	 * @author:        Ajie  
	 * @date:          2019年9月18日 上午11:19:09
	 */
	public static List<File> getFiles(String realpath, List<File> files) {
		File realFile = new File(realpath);
		if (realFile.isDirectory()) {
			File[] subfiles = realFile.listFiles();
			for (File file : subfiles) {
				if (file.isDirectory()) {
					getFiles(file.getAbsolutePath(), files);
				} else {
					files.add(file);
				}
			}
		}
		return files;
	}

}
