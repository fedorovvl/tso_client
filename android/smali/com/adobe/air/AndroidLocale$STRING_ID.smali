.class public final enum Lcom/adobe/air/AndroidLocale$STRING_ID;
.super Ljava/lang/Enum;
.source "AndroidLocale.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidLocale;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "STRING_ID"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/AndroidLocale$STRING_ID;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_CANCEL:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_CONTEXT_MENU_TITLE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_CONTINUE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_COPY_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_COPY_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_CUT_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_CUT_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_DEBUGGER_ENTERIP_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_DEBUGGER_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_DEBUGGER_LISTEN_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_DEBUGGER_LISTEN_ERROR_TITLE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_INPUT_METHOD_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_OK:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_PASTE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_RUNTIME_UPDATE_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_SELECT_ALL:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_SELECT_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_STOP_SELECTING_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

.field public static final enum IDA_UPDATE:Lcom/adobe/air/AndroidLocale$STRING_ID;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 11
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_CONTEXT_MENU_TITLE_STRING"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CONTEXT_MENU_TITLE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 12
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_CUT_ALL_STRING"

    invoke-direct {v0, v1, v4}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CUT_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 13
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_CUT_STRING"

    invoke-direct {v0, v1, v5}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CUT_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 14
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_PASTE_STRING"

    invoke-direct {v0, v1, v6}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_PASTE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 15
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_COPY_ALL_STRING"

    invoke-direct {v0, v1, v7}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_COPY_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 16
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_COPY_STRING"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_COPY_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 17
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_INPUT_METHOD_STRING"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_INPUT_METHOD_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 18
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_UPDATE"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_UPDATE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 19
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_CANCEL"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CANCEL:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 20
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_RUNTIME_UPDATE_MESSAGE"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_RUNTIME_UPDATE_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 21
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_OK"

    const/16 v2, 0xa

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_OK:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 22
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_DEBUGGER_ENTERIP_MESSAGE"

    const/16 v2, 0xb

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ENTERIP_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 23
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_DEBUGGER_ERROR_MESSAGE"

    const/16 v2, 0xc

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 24
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_CONTINUE"

    const/16 v2, 0xd

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CONTINUE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 25
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_DEBUGGER_LISTEN_ERROR_TITLE"

    const/16 v2, 0xe

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_LISTEN_ERROR_TITLE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 26
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_DEBUGGER_LISTEN_ERROR_MESSAGE"

    const/16 v2, 0xf

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_LISTEN_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 27
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_SELECT_TEXT"

    const/16 v2, 0x10

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_SELECT_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 28
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_STOP_SELECTING_TEXT"

    const/16 v2, 0x11

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_STOP_SELECTING_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 29
    new-instance v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    const-string v1, "IDA_SELECT_ALL"

    const/16 v2, 0x12

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidLocale$STRING_ID;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_SELECT_ALL:Lcom/adobe/air/AndroidLocale$STRING_ID;

    .line 10
    const/16 v0, 0x13

    new-array v0, v0, [Lcom/adobe/air/AndroidLocale$STRING_ID;

    sget-object v1, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CONTEXT_MENU_TITLE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CUT_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CUT_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v1, v0, v5

    sget-object v1, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_PASTE_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v1, v0, v6

    sget-object v1, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_COPY_ALL_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_COPY_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_INPUT_METHOD_STRING:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_UPDATE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CANCEL:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_RUNTIME_UPDATE_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xa

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_OK:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xb

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ENTERIP_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xc

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xd

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_CONTINUE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xe

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_LISTEN_ERROR_TITLE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0xf

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_DEBUGGER_LISTEN_ERROR_MESSAGE:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0x10

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_SELECT_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0x11

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_STOP_SELECTING_TEXT:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    const/16 v1, 0x12

    sget-object v2, Lcom/adobe/air/AndroidLocale$STRING_ID;->IDA_SELECT_ALL:Lcom/adobe/air/AndroidLocale$STRING_ID;

    aput-object v2, v0, v1

    sput-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->$VALUES:[Lcom/adobe/air/AndroidLocale$STRING_ID;

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
    .line 10
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/AndroidLocale$STRING_ID;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 10
    const-class v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidLocale$STRING_ID;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/AndroidLocale$STRING_ID;
    .locals 1

    .prologue
    .line 10
    sget-object v0, Lcom/adobe/air/AndroidLocale$STRING_ID;->$VALUES:[Lcom/adobe/air/AndroidLocale$STRING_ID;

    invoke-virtual {v0}, [Lcom/adobe/air/AndroidLocale$STRING_ID;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/AndroidLocale$STRING_ID;

    return-object v0
.end method
