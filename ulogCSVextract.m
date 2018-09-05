function output = ulogCSVextract(logName,logExtension)

output = cell(length(logExtension),length(logName));
header = cell(length(logExtension),1);
for i = 1:length(logName)
    for j = 1:length(logExtension)
        
        filename = [logName{i},logExtension{j},'.csv'];
        file.data = csvread(filename,1,0);
        
        fid = fopen(filename, 'r');
        temp = textscan(fid,'%s',1);
        file.header = strsplit(temp{1}{1},',');
        fclose(fid);
        
        file.logName = logName{i};
        file.extension = logExtension{j};
        
        output{j,i} = file;
        %Header check
        if i>1
            isSameHead = isempty(setdiff(header{j},file.header));
            if ~isSameHead
                error('Header is not identical for same extension file')
            end
        else
            header{j,1} = file.header;
        end
    end
end
