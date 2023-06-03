.class final enum Lcom/adobe/air/ControlType;
.super Ljava/lang/Enum;
.source "AndroidInputManager.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/ControlType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/ControlType;

.field public static final enum AXIS:Lcom/adobe/air/ControlType;

.field public static final enum BUTTON:Lcom/adobe/air/ControlType;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 454
    new-instance v0, Lcom/adobe/air/ControlType;

    const-string v1, "BUTTON"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/ControlType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/ControlType;->BUTTON:Lcom/adobe/air/ControlType;

    .line 455
    new-instance v0, Lcom/adobe/air/ControlType;

    const-string v1, "AXIS"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/ControlType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/ControlType;->AXIS:Lcom/adobe/air/ControlType;

    .line 452
    const/4 v0, 0x2

    new-array v0, v0, [Lcom/adobe/air/ControlType;

    sget-object v1, Lcom/adobe/air/ControlType;->BUTTON:Lcom/adobe/air/ControlType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/ControlType;->AXIS:Lcom/adobe/air/ControlType;

    aput-object v1, v0, v3

    sput-object v0, Lcom/adobe/air/ControlType;->$VALUES:[Lcom/adobe/air/ControlType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 452
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/ControlType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 452
    const-class v0, Lcom/adobe/air/ControlType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/ControlType;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/ControlType;
    .locals 1

    .prologue
    .line 452
    sget-object v0, Lcom/adobe/air/ControlType;->$VALUES:[Lcom/adobe/air/ControlType;

    invoke-virtual {v0}, [Lcom/adobe/air/ControlType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/ControlType;

    return-object v0
.end method
