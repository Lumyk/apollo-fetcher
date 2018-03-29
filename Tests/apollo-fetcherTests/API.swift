//  This file was automatically generated and should not be edited.

import Apollo

public final class CarsQuery: GraphQLQuery {
  public static let operationString =
    "query cars($limit: Int!) {\n  userInfo: getUserProfile {\n    __typename\n    id\n    username\n    email\n    company {\n      __typename\n      name\n    }\n  }\n  cars: getCars {\n    __typename\n    id\n    registration_number\n    name\n  }\n  getFields(limit: $limit) {\n    __typename\n    name\n    id\n    field_group {\n      __typename\n      name\n    }\n  }\n}"

  public var limit: Int

  public init(limit: Int) {
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getUserProfile", alias: "userInfo", type: .object(UserInfo.selections)),
      GraphQLField("getCars", alias: "cars", type: .list(.object(Car.selections))),
      GraphQLField("getFields", arguments: ["limit": GraphQLVariable("limit")], type: .list(.object(GetField.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(userInfo: UserInfo? = nil, cars: [Car?]? = nil, getFields: [GetField?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "userInfo": userInfo.flatMap { (value: UserInfo) -> Snapshot in value.snapshot }, "cars": cars.flatMap { (value: [Car?]) -> [Snapshot?] in value.map { (value: Car?) -> Snapshot? in value.flatMap { (value: Car) -> Snapshot in value.snapshot } } }, "getFields": getFields.flatMap { (value: [GetField?]) -> [Snapshot?] in value.map { (value: GetField?) -> Snapshot? in value.flatMap { (value: GetField) -> Snapshot in value.snapshot } } }])
    }

    public var userInfo: UserInfo? {
      get {
        return (snapshot["userInfo"] as? Snapshot).flatMap { UserInfo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "userInfo")
      }
    }

    public var cars: [Car?]? {
      get {
        return (snapshot["cars"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Car?] in value.map { (value: Snapshot?) -> Car? in value.flatMap { (value: Snapshot) -> Car in Car(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Car?]) -> [Snapshot?] in value.map { (value: Car?) -> Snapshot? in value.flatMap { (value: Car) -> Snapshot in value.snapshot } } }, forKey: "cars")
      }
    }

    public var getFields: [GetField?]? {
      get {
        return (snapshot["getFields"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [GetField?] in value.map { (value: Snapshot?) -> GetField? in value.flatMap { (value: Snapshot) -> GetField in GetField(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [GetField?]) -> [Snapshot?] in value.map { (value: GetField?) -> Snapshot? in value.flatMap { (value: GetField) -> Snapshot in value.snapshot } } }, forKey: "getFields")
      }
    }

    public struct UserInfo: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("username", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("company", type: .object(Company.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, username: String? = nil, email: String? = nil, company: Company? = nil) {
        self.init(snapshot: ["__typename": "User", "id": id, "username": username, "email": email, "company": company.flatMap { (value: Company) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// ID of object
      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// Username for user
      public var username: String? {
        get {
          return snapshot["username"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }

      /// Email for the user
      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      /// User' company
      public var company: Company? {
        get {
          return (snapshot["company"] as? Snapshot).flatMap { Company(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "company")
        }
      }

      public struct Company: GraphQLSelectionSet {
        public static let possibleTypes = ["Company"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil) {
          self.init(snapshot: ["__typename": "Company", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Company name
        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }
    }

    public struct Car: GraphQLSelectionSet {
      public static let possibleTypes = ["Car"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("registration_number", type: .scalar(String.self)),
        GraphQLField("name", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, registrationNumber: String? = nil, name: String? = nil) {
        self.init(snapshot: ["__typename": "Car", "id": id, "registration_number": registrationNumber, "name": name])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// ID of object
      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// Machine registration number
      public var registrationNumber: String? {
        get {
          return snapshot["registration_number"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "registration_number")
        }
      }

      /// Machine name
      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }
    }

    public struct GetField: GraphQLSelectionSet {
      public static let possibleTypes = ["Field"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("field_group", type: .object(FieldGroup.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String? = nil, id: GraphQLID, fieldGroup: FieldGroup? = nil) {
        self.init(snapshot: ["__typename": "Field", "name": name, "id": id, "field_group": fieldGroup.flatMap { (value: FieldGroup) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Field name
      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      /// ID of object
      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// Field FieldGroup
      public var fieldGroup: FieldGroup? {
        get {
          return (snapshot["field_group"] as? Snapshot).flatMap { FieldGroup(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "field_group")
        }
      }

      public struct FieldGroup: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldGroup"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil) {
          self.init(snapshot: ["__typename": "FieldGroup", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// FieldGroup name
        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class SignInMutation: GraphQLMutation {
  public static let operationString =
    "mutation signIn($email: String!, $password: String!) {\n  signIn(login_params: {email: $email, password: $password}) {\n    __typename\n    authentication_token\n    language\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["MutationRoot"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("signIn", arguments: ["login_params": ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")]], type: .object(SignIn.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(signIn: SignIn? = nil) {
      self.init(snapshot: ["__typename": "MutationRoot", "signIn": signIn.flatMap { (value: SignIn) -> Snapshot in value.snapshot }])
    }

    public var signIn: SignIn? {
      get {
        return (snapshot["signIn"] as? Snapshot).flatMap { SignIn(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "signIn")
      }
    }

    public struct SignIn: GraphQLSelectionSet {
      public static let possibleTypes = ["UserLoginData"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("authentication_token", type: .scalar(String.self)),
        GraphQLField("language", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(authenticationToken: String? = nil, language: String? = nil) {
        self.init(snapshot: ["__typename": "UserLoginData", "authentication_token": authenticationToken, "language": language])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// User api token
      public var authenticationToken: String? {
        get {
          return snapshot["authentication_token"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "authentication_token")
        }
      }

      /// User's language
      public var language: String? {
        get {
          return snapshot["language"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "language")
        }
      }
    }
  }
}
