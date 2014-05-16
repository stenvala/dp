%% setCoordinatesName.m
%
% set name for coordinate system
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setCoordinatesActive(this,indOrName)
if isnumeric(indOrName)
    if indOrName > length(this.charts) || ...
            round(indOrName) ~= indOrName || indOrName < 1
        exception = MException('SetError:RequestedChartDoesNotExist', ...
            'Illegal chart index.');
        throw(exception);
    end
    this.chartsActive = indOrName;
    return
end

% else we know that indOrName is string
for k=1:length(this.charts)
    if strcmp(this.charts{k}.name,indOrName)
        this.chartsActive = k;
        return
    end
end
exception = MException('SetError:RequestedChartDoesNotExist', ...
    'Illegal chart name.');
throw(exception);

end