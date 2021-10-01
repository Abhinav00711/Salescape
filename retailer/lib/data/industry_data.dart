import '../models/industry.dart';

class IndustryData {
  List<Industry> _items = [
    Industry(
      name: 'Agriculture',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2FAgriculture.png?alt=media&token=4b002a48-0028-4ff5-92ea-73ac6ce0032b',
    ),
    Industry(
      name: 'Healthcare and Pharmaceutical',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2FHealthcare_and_pharmaceutical.png?alt=media&token=88e6d5c7-70da-4bd7-bdbb-18b0783dcd20',
    ),
    Industry(
      name: 'Infrastructure',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Finfrastructure.png?alt=media&token=cd458adb-1112-4882-b6ef-108a7617fde0',
    ),
    Industry(
      name: 'FMCG',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Ffmcg.png?alt=media&token=cffcb97e-8b0a-4bdc-8f3b-45542cae287d',
    ),
    Industry(
      name: 'Fashion and Textiles',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Ffashion_and_textile.png?alt=media&token=c0442870-8651-44da-8278-5367618bf250',
    ),
    Industry(
      name: 'Automobile',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Fautomobile.png?alt=media&token=ace0209d-8516-48e4-94fa-b52e94f83d02',
    ),
    Industry(
      name: 'Chemical',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Fchemical.png?alt=media&token=a5602f7b-af49-4391-8155-65e512501685',
    ),
    Industry(
      name: 'Electronics and Appliances',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Felectronics_and_appliances.png?alt=media&token=058962b8-54b9-4c6d-8e0d-b99852df2a9d',
    ),
    Industry(
      name: 'Furniture and Furnishing',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Ffurniture_and_furnishing.png?alt=media&token=423fd557-866b-49c8-85b7-4876e975bff3',
    ),
    Industry(
      name: 'Sports and Fitness',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Fsports_and_fitness.png?alt=media&token=7b53ab50-9cbd-46f0-ae40-215349ac1784',
    ),
    Industry(
      name: 'Household',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/salescape-4b9ae.appspot.com/o/Industry%2Fhousehold.jpeg?alt=media&token=ec5fad33-7a92-419e-a90b-cefb97624e18',
    ),
  ];

  List<Industry> get items {
    return [..._items];
  }
}
