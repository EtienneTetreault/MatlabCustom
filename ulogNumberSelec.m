function logName = ulogNumberSelec(logNumberWanted)

logStruct = struct2cell(dir ('Log*.ulg'));
NameStr = logStruct(1,:).';
NameStr = sortrows(NameStr);

counter = 0;
logName = cell(length(logNumberWanted),1);
for i = 1:length(NameStr)
    strToCheck = NameStr{i};
    logNumber = regexp(strToCheck,'(?<=_)\d+(?=_)','match');
    ToKeep = any(ismember(logNumberWanted,str2double(logNumber{1})));
    if ToKeep
        counter = counter +1;
        logName{counter,1} = NameStr{i}(1:end-4);
    end
end
