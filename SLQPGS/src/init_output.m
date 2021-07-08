function o = init_output(i)

% function o = init_output(i)
%
% Author       : Frank E. Curtis
% Description  : Initializes output by opening output files, setting
%                verbosity level, and storing output header strings.
% Input        : i ~ inputs
% Output       : o ~ output data
% Last revised : 1 February 2011

% Set output file handle
if ~isfield(i,'output_file'), o.fout = 1;
else

  % Open output file for writing
  o.fout = fopen(i.output_file,'w');
  
  % Assert that output file is writable
  assert(o.fout~=-1, sprintf('SLQP-GS: Error opening output file, %s.',i.output_file));

end

% Set verbosity level to ...
if isfield(i,'verbosity') & isnumeric(i.verbosity) & isscalar(i.verbosity) & round(i.verbosity) == i.verbosity
  % ... input
  o.verbosity = i.verbosity;
else
  % ... default
  o.verbosity = 0;
end

% Store output strings
if o.verbosity == 0 | o.verbosity == 2
  o.line = '======+===================================================+============+===========';
  o.quan = 'Iter. |  Objective     Infeas.  |  Pen. Par.     Merit    |  ||Step||  |  Steplen.';
  o.none =                                                             '---------- | ----------';
else
  o.line = '======+===================================================+==========================================================================+===========';
  o.quan = 'Iter. |  Objective     Infeas.  |  Pen. Par.     Merit    | Samp. Rad.   Inf. Rad.  Size  Msg.   ||Step||      Model      Mod. Red.  |  Steplen.';
  o.none =                                                             '----------  ----------  ----  ----  ----------  -----------  ----------- | ----------';
end
