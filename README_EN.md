# 🚚 Freight System

## Test Coverage - SimpleCov
![image](https://user-images.githubusercontent.com/92264330/170708155-7d363d2d-03d6-48d0-a1c5-4ec9dd8a5128.png)

<p align="right">
  <a href='https://github.com/philipeleandro/Freight-System/blob/main/README.md'>Portuguese-BR</a>
</p>

## 📖 Description
Freight system is a platform for managing product deliveries that can be used by companies

- **Admin:** It register companies, create service orders and consult prices
- **Regular User:** It registers vehicles, configures prices and deadlines for companies, follows up on service orders.
- **Visitor:** Check delivery status

## 🚀 Instruction
Use the following command to clone the repository:
```sh
git clone https://github.com/philipeleandro/Freight-System
```
Run
`bundle install`

## 🖥️ What to do on Freight System?
The Freight system allows access for visitors, users of registered carriers and system administrators, in which the system functions available for each of them are different.

### 🧑‍💼 Administrators
These administrators have a different email domain for login, in this system the domain is `sistemadeentregas.com.br`. The admins perform the functions of registering new carriers to the system with the information of each company, in addition to create services orders forwarding directly to the desired carrier. In the system it is also possible for the administrator to check the existing services orders and make a price query and see the registered values of each carrier to then create the service order to the chosen carrier.

### 👩‍🦰 Carrier users
Carriers' users have access by creating accounts when the user's email domains match the domains informed by the companies, in which case the email with the domain `example.com.br` could give access to a company that had the same domain informed in its creation in the Freight System.

Among the available functions, there is `Services` which will return the service orders linked to the carrier. This function displays a unique 15-character code, showing the status of the work order. If the status is `Pending`, the user can accept or refuse the service order, so, if accepted, the user will have the option to `update the order route`, in which he can inform the place, time and date of where the order is located.

The `Register Car` functions are available in the Freight system, in which the user will provide information on the cars to be used in the services; the `Register Price` function is where the carrier user will fill in the weight(kg), volume(m³) ranges and the values per km to be charged; already `Register Deadline`, the user will inform the distance values (km) and the working days that comprise that delivery interval.

For carrier users, it is also possible to check prices and delivery times already registered by carriers through the `Price Inquiry` and `Deadline Inquiry` functions, respectively.

### 👨🏾‍🦱 Visitors
For users who are not logged in, that is, users who are not recognized as administrators or users of the carriers, on the system's home page it is possible, through a search bar, to search for work order information using the unique 15-character codes generated in the creation of the work order.