# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#,
# Examples:,
#,
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }]),
#   Character.create(name: 'Luke', movie: movies.first),
vtZips = ['00000', '05001', '05032', '05033', '05034', '05035', '05036', '05037',
  '05038', '05039', '05040', '05041', '05042', '05043', '05045', '05046', '05048',
  '05051', '05052', '05053', '05055', '05056', '05058', '05060', '05061', '05062',
  '05065', '05067', '05068', '05069', '05070', '05071', '05072', '05075', '05076',
  '05077', '05079', '05081', '05083', '05084', '05086', '05089', '05091', '05101',
  '05142', '05143', '05146', '05148', '05149', '05150', '05151', '05152', '05153',
  '05154', '05155', '05156', '05158', '05161', '05201', '05250', '05251', '05252',
  '05253', '05255', '05257', '05260', '05261', '05262', '05301', '05340', '05341',
  '05342', '05343', '05345', '05346', '05350', '05352', '05353', '05354', '05355',
  '05356', '05358', '05359', '05360', '05361', '05362', '05363', '05401', '05403',
  '05404', '05408', '05440', '05441', '05442', '05443', '05444', '05445', '05446',
  '05448', '05450', '05452', '05454', '05455', '05456', '05457', '05458', '05459',
  '05461', '05462', '05463', '05464', '05465', '05468', '05471', '05472', '05473',
  '05474', '05476', '05477', '05478', '05482', '05483', '05486', '05487', '05488',
  '05489', '05491', '05492', '05494', '05495', '05602', '05641', '05647', '05648',
  '05649', '05650', '05651', '05652', '05653', '05654', '05655', '05656', '05658',
  '05660', '05661', '05663', '05667', '05669', '05672', '05673', '05674', '05675',
  '05676', '05677', '05679', '05680', '05681', '05682', '05701', '05730', '05732',
  '05733', '05734', '05735', '05736', '05737', '05738', '05739', '05742', '05743',
  '05744', '05747', '05748', '05751', '05753', '05757', '05758', '05759', '05760',
  '05761', '05762', '05763', '05764', '05765', '05766', '05767', '05769', '05770',
  '05772', '05773', '05774', '05775', '05776', '05777', '05778', '05819', '05820',
  '05821', '05822', '05824', '05826', '05827', '05828', '05829', '05830', '05832',
  '05833', '05836', '05837', '05839', '05841', '05842', '05843', '05845', '05846',
  '05847', '05850', '05851', '05853', '05855', '05857', '05858', '05859', '05860',
  '05862', '05866', '05867', '05868', '05871', '05872', '05873', '05874', '05875',
  '05903', '05904', '05905', '05906']



Representative.create(name: 'Bernie Sanders', state: 'VT', party: 'I', address: 'U.S. Senate 332 Dirksen Building Washington, D.C. 20510', website: 'https://www.sanders.senate.gov/contact/comment', image: 'https://lh4.googleusercontent.com/-MoJHeOqT5Pg/AAAAAAAAAAI/AAAAAAAAUGY/QK9h6BxPcP8/s0-c-k-no-ns/photo.jpg', phone: '(802) 862-0697')
Representative.create(name: 'Patrick Leahy', state: 'VT', party: 'D', address: '437 Russell Senate Bldg United States Senate Washington, DC 20510', website: 'https://www.leahy.senate.gov/contact', image: 'https://d229l5sflpl9cp.cloudfront.net/canphoto/53353_lg.jpg', phone: '(202) 224-4242')
Representative.create(name: 'Peter Welch', state: 'VT', party: 'D', address: '2303 Rayburn House Office Building Washington, DC 20515', website: 'https://welch.house.gov/contact', image: 'https://pbs.twimg.com/profile_images/593413173455257600/o0GKZGhi.jpg', phone: '(202) 225-4115')
vtZips.each do |zip|
  Zipcode.create(zip: zip)
  Rzip.create(zipcode_id: Zipcode.find_by(zip: zip).id, representative_id: 1)
  Rzip.create(zipcode_id: Zipcode.find_by(zip: zip).id, representative_id: 2)
  Rzip.create(zipcode_id: Zipcode.find_by(zip: zip).id, representative_id: 3)
end
