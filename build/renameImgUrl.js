const fs = require('fs');
const path = require('path');
const config = require('./config');

// 获取所有文件
function readDir(fileDir) {
    fs.readdir(fileDir, (err, files) => {
        if (err) throw err;
    
        files.forEach((file) => {
            let filePath = path.join(fileDir, file);
    
            fs.stat(filePath, (err, stats) => {
                if (err) throw err;

                if (stats.isFile()) {
                    modifyFile(filePath);
                }
                if (stats.isDirectory()) {
                    readDir(filePath);
                }
            })
        })
    })
}

// 替换图片路径
function modifyFile(filePath) {
    fs.readFile(filePath, (err, data) => {
        if (err) throw err;
        
        let file = data.toString('UTF-8')
        .replace(/(\.\.\/)+(?=src\/images)/ig, '/')
        .replace(/(\/src\/images\/[\/\w_-]+?(?:\.(png|jpg|jpeg|svg|gif|bmp)))/ig, config.imageDirPrefix + '$1');
        fs.writeFile(filePath, file, (err) => {
            if (err) throw err;
        })
    })
}

config.fileDirs.forEach((fileDir) => {
    if (/\.(html|json)/ig.test(fileDir)) {
        modifyFile(fileDir);
    } else {
        readDir(fileDir);
    }
});