% vim: tabstop=2 shiftwidth=2 expandtab
%
% Stress–strain Curve
%
% @author Damien Bezborodov <dbezborodov@gmail.com>
%
% sudo apt install octave-statistics octave-matgeom
%
% https://mechcontent.com/modulus-of-resilience/#What_is_resilience

pkg load statistics
pkg load matgeom

function [E, yield, tensileStrength, resilience, toughness, resilienceByArea, resilienceByYield] = ssplot(csvfile, outfile, subject)
  hold off;
  data = csvread(csvfile);

  % Stress/strain plot
  stress = data(15:end, 5);
  strain = data(15:end, 4);
  plot(strain, stress);

  % Decorate plot.
  hold on;
  title(subject);
  ylabel('Stress \sigma (MPa)');
  xlabel('Strain \epsilon (mm/mm)');
  grid on;
  grid minor on;

  % Find linear region and elastic modulus.
  for i = 15:rows(data)
    [b, bint, r, rint, stats] = regress(stress(1:i), strain(1:i));
    R2 = stats(1);
    if R2 < 0.95
      break
    end
  end
  E = b * 10^6;
  linearx = strain(1:end) + 0.002;
  lineary = b*strain(1:end);
  plot(linearx(1:i), lineary(1:i));

  % Yield strength (intersection.)
  sspolyline = cat(2, strain, stress);
  yield = intersectPolylines(cat(2, linearx, lineary), sspolyline);
  plot(yield(1), yield(2), 'k*');
  label = strcat(' \sigma_y = ', num2str(yield(2), 4));
  text(yield(1), yield(2), label);

  % Resilience.
  intersectIdx = findClosestPoint(yield, sspolyline);
  resilienceByArea = trapz(strain(1:intersectIdx), 10^6 * stress(1:intersectIdx));

  % Tensile strength (maximum.)
  [ymax, xmax_idx] = max(stress);
  xmax = strain(xmax_idx);
  tensileStrength = ymax;
  plot(xmax, ymax, 'k*');
  label = strcat(num2str(ymax, 4));
  text(xmax, ymax, label, 'verticalalignment', 'top');

  % Toughness.
  toughness = trapz(strain(1:end), 10^6 * stress(1:end));

  % Save stress/strain plot.
  saveas(1, strcat(outfile, '.svg'));
  print(strcat(outfile, '.png'), '-dpng', '-r300');

  % Other calculations.
  sigma_y = yield(2) * 10^6;
  epsilon_y = yield(1);
  resilienceByYield = 1/2 * sigma_y * epsilon_y;
  resilience = sigma_y^2 / (2*E);

  % Plot for linear region only.
  hold off
  plot(strain(1:intersectIdx), stress(1:intersectIdx));
  hold on
  plot(linearx(1:i), lineary(1:i));
  plot(yield(1), yield(2), 'k*');
  label = num2str(yield(2), 4);
  text(yield(1), yield(2), label);
  title(strcat(subject, ' Linear Region'));
  ylabel('Stress \sigma (MPa)');
  xlabel('Strain \epsilon (mm/mm)');
  grid on;
  grid minor on;
  saveas(1, strcat(outfile, '_1.svg'));
  print(strcat(outfile, '_1.png'), '-dpng', '-r300');

  % Residual case order plot.
  %hold off;
  %plot(r, rint);
  %saveas(1, strcat(outfile, '_2.svg'));
  %print(strcat(outfile, '_2.png'), '-dpng', '-r300');
end

format short eng

arg_list = argv();
file = arg_list{1};
[filepath, name, ext] = fileparts(file);

disp(name);
[E, y, UTS, Ur, Ut, UrA, Ury] = ssplot(
    file,
    name, name)
